import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/points/points_model.dart';

class PointsProvider with ChangeNotifier {
  PointsModel? _pointsModel;
  bool _isLoading = false;
  String? _errorMessage;

  PointsModel? get pointsModel => _pointsModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> convertPoints(
      BuildContext context, int currencyId, int points) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final String? token = loginProvider.token;

      if (token == null || token.isEmpty) {
        _errorMessage = 'Authentication token is missing';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await http.post(
        Uri.parse('https://bcknd.ticket-hub.net/user/points/convert'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'currency_id': currencyId,
          'points': points,
        }),
      );

      if (response.statusCode == 200) {
        log(response.body);
        await fetchPoints(context);
        return true;
      } else {
        final data = json.decode(response.body);
        _errorMessage = data['message'] ?? 'Failed to convert points';
        return false;
      }
    } catch (error) {
      log(error.toString());
      _errorMessage = 'An error occurred: $error';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPoints(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final String? token = loginProvider.token;

      if (token == null || token.isEmpty) {
        _errorMessage = 'Authentication token is missing';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse('https://bcknd.ticket-hub.net/user/points'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _pointsModel = PointsModel.fromJson(data);
      } else {
        _errorMessage = 'Failed to load data';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
