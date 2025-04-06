import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/private/private_model.dart';

class CarProvider with ChangeNotifier {
  List<Country> _countries = [];
  List<City> _cities = [];
  List<Brand> _brands = [];
  bool _isLoading = false;

  List<Country> get countries => _countries;
  List<City> get cities => _cities;
  List<Brand> get brands => _brands;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://bcknd.ticket-hub.net/user/booking/lists';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> countryData = responseData['countries'];
        _countries = countryData.map((json) => Country.fromJson(json)).toList();

        final List<dynamic> cityData = responseData['cities'];
        _cities = cityData.map((json) => City.fromJson(json)).toList();

        final List<dynamic> brandData = responseData['brands'];
        _brands = brandData.map((json) => Brand.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error'); 
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> sendBookingRequest({
    required BuildContext context,
    required String date,
    required int traveler,
    required int cityId,
    required String address,
    required int carId,
    required int fromCityId,
    required String fromAddress,
  }) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final String? token = loginProvider.token;

    if (token == null) {
      print('No authentication token available');
      return false;
    }

    const url = 'https://bcknd.ticket-hub.net/user/booking/private_request';
    final Map<String, dynamic> requestData = {
      'date': date,
      'traveler': traveler,
      'city_id': cityId,
      'address': address,
      'brand_id': carId,
      'from_city_id': fromCityId,
      'from_address': fromAddress,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.body);

        print('Booking request successful');
        return true;
      } else {
        log(response.body);

        print('Failed to send booking request: ${response.body}');
        return false;
      }
    } catch (error) {
      log(error.toString());
      print('Error sending booking request: $error');
      return false;
    }
  }
}
