import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_hub/model/auth/login_model.dart';
import 'package:ticket_hub/views/auth/login_screen.dart';

class LoginProvider extends ChangeNotifier {
  UserModel? _userModel;
  String? _token;
  bool _isLoading = false;
  String? _error;

  UserModel? get userModel => _userModel;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool isUserAuthenticated() => _token != null;

  Future<void> login(String email, String password) async {
    const String url = 'https://bcknd.ticket-hub.net/api/login_user';
    final prefs = await SharedPreferences.getInstance();
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
        await prefs.setString('token', _token!);
        notifyListeners();
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

  Future<void> logout(BuildContext context) async {
    const String url = 'https://bcknd.ticket-hub.net/api/logout';
    if (token == null) return;
    final prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200 &&
          responseData["success"] == "You have successfully logged out.") {
        log(response.body);
        _userModel = null;
        _error = null; // Clear any previous error
        _token = null; // Ensure token is removed
        prefs.remove('token');
      } else {
        log(response.body);
        _error = 'Logout failed: ${response.statusCode}, ${response.body}';
      }
    } catch (e) {
      log(e.toString());
      _error = 'Exception: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    const String url = 'https://bcknd.ticket-hub.net/api/delete_account';
    if (token == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
        _userModel = null;
        _error = null; // Clear any previous error
        _token = null; // Ensure token is removed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const LoginScreen()),
        );
      } else {
        log(response.body);
        _error = 'Logout failed: ${response.statusCode}, ${response.body}';
      }
    } catch (e) {
      log(e.toString());
      _error = 'Exception: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTokenFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }
}
