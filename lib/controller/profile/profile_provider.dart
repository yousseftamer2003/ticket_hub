import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/profile/profile_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> fetchUserProfile(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null) {
      log('No token found. User is not authenticated.');
      return;
    }

    const String url = 'https://bcknd.ticket-hub.net/user/profile';

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _user = UserModel.fromJson(responseData['user']);
      } else {
        log('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log('Exception: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserProfile({
    required BuildContext context,
    int? nationalityId,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? password,
    String? image,
  }) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null) {
      log('No token found. User is not authenticated.');
      return;
    }

    const String url = 'https://bcknd.ticket-hub.net/user/profile/update';

    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> body = {
        if (nationalityId != null) "nationality_id": nationalityId,
        "name": name,
        "email": email,
        "phone": phone,
      };

      if (gender != null && gender.isNotEmpty) {
        body["gender"] = gender;
      }

      if (password != null && password.isNotEmpty) {
        body["password"] = password;
      }

      if (image != null && image.isNotEmpty) {
        body["image"] = image;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('user') && responseData['user'] != null) {
          _user = UserModel.fromJson(responseData['user']);
          log('Profile updated successfully.');
        } else {
          log('Warning: "user" key not found in response: ${response.body}');
        }

        log(response.body);
      }
    } catch (e) {
      log('Exception: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
