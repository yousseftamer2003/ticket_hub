import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _message;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get message => _message;
  String? get errorMessage => _errorMessage;

  Future<void> changePassword(
      String email, String code, String newPassword) async {
    const String url = 'https://bcknd.ticket-hub.net/api/change_password';

    _isLoading = true;
    _message = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'code': code, 'new_password': newPassword}),
      );

      if (response.statusCode == 200) {
        _message = 'Password changed successfully!';
      } else {
        _errorMessage = 'Failed: ${response.body}';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendEmail(String email) async {
    const String url = 'https://bcknd.ticket-hub.net/api/forget_password';

    _isLoading = true;
    _message = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        _message = 'Password reset link sent successfully!';
      } else {
        _errorMessage = 'Failed: ${response.body}';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> checkCode(String email, String code) async {
    const String url = 'https://bcknd.ticket-hub.net/api/check_code';

    _isLoading = true;
    _message = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}),
      );

      if (response.statusCode == 200) {
        _message = 'Code verified successfully!';
        log(response.body);
      } else {
        _errorMessage = 'Invalid code: ${response.body}';
        log(response.body);
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
