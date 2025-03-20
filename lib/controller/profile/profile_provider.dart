import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/profile/profile_model.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileModel? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserProfile(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final String? token = loginProvider.token;

      if (token == null) {
        _errorMessage = "No authentication token available.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse("https://bcknd.ticket-hub.net/user/profile"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _userProfile = UserProfileModel.fromJson(data['data']);
        log(response.body);
      } else {
        _errorMessage = "Failed to load profile: ${response.body}";
        _userProfile = null;
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
      _errorMessage = "Error fetching user profile: $e";
      _userProfile = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
