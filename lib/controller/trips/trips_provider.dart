import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/trips/trips_model.dart';

class TripsProvider extends ChangeNotifier {
  TripsData? _tripsData;
  bool _isLoading = false;
  String _errorMessage = '';

  TripsData? get tripsData => _tripsData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchTripHistory(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null || token.isEmpty) {
      _errorMessage = 'Authentication token is missing';
      notifyListeners();
      return;
    }

    const String url = 'https://bcknd.ticket-hub.net/user/booking/history';

    _isLoading = true;
    _errorMessage = '';
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
        final Map<String, dynamic> data = json.decode(response.body);
        _tripsData = TripsData.fromJson(data);
      } else {
        _errorMessage = 'Failed to load trip history (Status: ${response.statusCode})';
      }
    } catch (e) {
      _errorMessage = 'Error fetching trip history: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
