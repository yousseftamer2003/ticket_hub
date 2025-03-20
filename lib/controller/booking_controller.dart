import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/model/booking/booking_lists_model.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_hub/model/booking/search_result.dart';

class BookingController with ChangeNotifier {
  List<City> _cities = [];
  List<City> get cities => _cities;

  List<PaymentMethod> _paymentMethods = [];
  List<PaymentMethod> get paymentMethods => _paymentMethods;

  AllTrips? _allTrips;
  AllTrips? get allTrips => _allTrips;

  Future<void> fetchCitiesandPaymentMethods(BuildContext context) async {
    try {
      final authServices = Provider.of<LoginProvider>(context,listen: false);
      final token = authServices.token;

      final response = await http.get(Uri.parse('https://bcknd.ticket-hub.net/user/booking/lists'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        Cities cities = Cities.fromJson(responseData);
        _cities = cities.cities.map((x) => City.fromJson(x)).toList();
        // PaymentMethods paymentMethods = PaymentMethods.fromJson(responseData);
        // _paymentMethods = paymentMethods.paymentMethods.map((x) => PaymentMethod.fromJson(x)).toList();
        notifyListeners();
      }else{
        log('Failed to load cities. Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log('Error fetching cities: $e');
    }
  }

  Future<void> searchTrips(BuildContext context,{
    required String from,
    required String to,
    required String departureDate,
    String? returnDate,
    required int travelers,
  }) async{
    try {
      final authServices = Provider.of<LoginProvider>(context,listen: false);
      final token = authServices.token;

      final body = returnDate != null ? jsonEncode({
        'from': from,
        'to': to,
        'date': departureDate,
        'return_date': returnDate,
        'travelers': travelers,
        'type': 'round_trip'
      }) : 
      jsonEncode({
        'from': from,
        'to': to,
        'date': departureDate,
        'travelers': travelers,
        'type': 'one_way'
      });

      final response = await http.post(Uri.parse('https://bcknd.ticket-hub.net/user/booking'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
      );
      if(response.statusCode == 200){

      }else{
        log('Failed to search trips. Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log('Error searching trips: $e');
    }
  }
}