import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_hub/model/auth/list_model.dart';


class NationalityProvider extends ChangeNotifier {
  List<Nationality> _nationalities = [];
  bool _isLoading = false;

  List<Nationality> get nationalities => _nationalities;
  bool get isLoading => _isLoading;

  Future<void> fetchNationalities() async {
    _isLoading = true;
    notifyListeners();

    const String url = 'https://bcknd.ticket-hub.net/api/lists';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _nationalities = List<Nationality>.from(
          data['nationality'].map((x) => Nationality.fromJson(x)),
        );
      } else {
        log('Failed to load nationalities. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching nationalities: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
