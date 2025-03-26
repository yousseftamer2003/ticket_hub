import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_hub/model/auth/login_model.dart';

class LoginProvider extends ChangeNotifier {
  UserModel? _userModel;
  String? _token;
  bool _isLoading = false;
  String? _error;

  UserModel? get userModel => _userModel;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    const String url = 'https://bcknd.ticket-hub.net/api/login_user';
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log(response.body);

        _userModel = UserModel.fromJson(jsonResponse);
        _token = _userModel?.token;
      } else {
        _error = 'Error: ${response.statusCode}, ${response.body}';
      }
    } catch (e) {
      _error = 'Exception: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
