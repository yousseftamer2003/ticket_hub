import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_hub/views/tabs_screen/screens/tabs_screen.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> signupUser({
    required String password,
    required String email,
    required int? nationalityId,
    required String name,
    required String phone,
    required String? gender,
    required BuildContext context,
  }) async {
    const String url = "https://bcknd.ticket-hub.net/api/register";
    final prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    String? nationalityIdString = nationalityId?.toString();

    if (nationalityId == null) {
      nationalityIdString = "60";
    }

    try {
      Map<String, dynamic> requestBody = {
        'password': password,
        'email': email,
        'nationality_id': nationalityIdString,
        'name': name,
        'phone': phone,
      };

      // Only include gender if it's not null
      if (gender != null) {
        requestBody['gender'] = gender;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['token'] != null) {
          log("Registration Successful: ${response.body}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TabsScreen()),
          );
          await prefs.setString('token', data['token']);
        } else {
          _errorMessage = "Failed to retrieve token";
          log("Token not found in response");
        }
      } else {
        _errorMessage = "Failed: ${response.body}";
        log("Registration Failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      _errorMessage = "Error: $e";
      log("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
