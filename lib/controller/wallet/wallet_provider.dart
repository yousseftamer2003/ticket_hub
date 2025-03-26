import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/wallet/wallet_history_model.dart';
import 'package:ticket_hub/model/wallet/wallet_model.dart';

class WalletProvider extends ChangeNotifier {  
  List<Wallet> _wallets = [];
  List<TransactionHistory> _walletHistory = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Wallet> get wallets => _wallets;
  List<TransactionHistory> get walletHistory => _walletHistory;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchWallets(BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null) {
      _errorMessage = 'User is not logged in.';
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url = Uri.parse('https://bcknd.ticket-hub.net/user/wallet');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _wallets = List<Wallet>.from(data["wallets"].map((x) => Wallet.fromMap(x)));
      } else {
        _errorMessage = 'Failed to load wallets: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchWalletHistory(BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null) {
      _errorMessage = 'User is not logged in.';
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url = Uri.parse('https://bcknd.ticket-hub.net/user/wallet/history');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _walletHistory = List<TransactionHistory>.from(
            data["history"].map((x) => TransactionHistory.fromJson(x)));
      } else {
        _errorMessage = 'Failed to load wallet history: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error fetching wallet history: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> chargeWallet(BuildContext context, String walletId, double amount, String paymentMethodId, String imageBase64) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null) {
      _errorMessage = 'User is not logged in.';
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url = Uri.parse('https://bcknd.ticket-hub.net/user/wallet/charge');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'wallet_id': walletId,
          'amount': amount,
          'payment_method_id': paymentMethodId,
          'image': imageBase64,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success response
      } else {
        _errorMessage = 'Failed to charge wallet: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error charging wallet: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}