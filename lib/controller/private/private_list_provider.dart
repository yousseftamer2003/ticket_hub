import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/private/private_model.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Country> _countries = [];
  List<City> _cities = [];
  bool _isLoading = false;

  List<Car> get cars => _cars;
  List<Country> get countries => _countries;
  List<City> get cities => _cities;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://bcknd.ticket-hub.net/user/booking/lists';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Fetch Cars
        final List<dynamic> carData = responseData['car'];
        _cars = carData.map((json) => Car.fromJson(json)).toList();

        // Fetch Countries
        final List<dynamic> countryData = responseData['countries'];
        _countries = countryData.map((json) => Country.fromJson(json)).toList();

        // Fetch Cities
        final List<dynamic> cityData = responseData['cities'];
        _cities = cityData.map((json) => City.fromJson(json)).toList();
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
    required int countryId,
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
      'country_id': countryId,
      'city_id': cityId,
      'address': address,
      'car_id': carId,
      'from_city_id': fromCityId,
      'from_address': fromAddress,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include token for authentication
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
