import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/wallet/list_model.dart';

class PaymentProvider with ChangeNotifier {
  PaymentDataModel? _paymentData;
  bool _isLoading = false;
  String? _errorMessage;

  PaymentDataModel? get paymentData => _paymentData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPaymentData(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final String? token = loginProvider.token;

      if (token == null) {
        _errorMessage = 'Authentication token is missing';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse('https://bcknd.ticket-hub.net/user/wallet/lists'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _paymentData = PaymentDataModel.fromJson(data);
      } else {
        _errorMessage = 'Failed to load data';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
