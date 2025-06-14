import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_snack_bar.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/controller/payment_web_view.dart';
import 'package:ticket_hub/model/booking/booking_lists_model.dart';
import 'package:ticket_hub/model/booking/search_data.dart';
import 'package:ticket_hub/model/booking/search_result.dart';
import 'package:ticket_hub/views/tabs_screen/screens/tabs_screen.dart';

class BookingController with ChangeNotifier {
  List<City> _cities = [];
  List<City> get cities => _cities;

  List<PaymentMethod> _paymentMethods = [];
  List<PaymentMethod> get paymentMethods => _paymentMethods;

  TripResponse? _searchResult;
  TripResponse? get searchResult => _searchResult;

  List<int> chosenSeats = [];
  SearchData searchData = SearchData();
  Trip? selectedTrip;

  void setTrip(Trip trip) {
    selectedTrip = trip;
    notifyListeners();
  }

  bool isCitiesLoaded = false;

  void setTripType(String type) {
    searchData.type = type;
    notifyListeners();
  }

  Future<void> searchTrips(BuildContext context) async {
    try {
      Map<String, dynamic> requestBody = {
        'from': searchData.departureFromId,
        'to': searchData.arrivalToId,
        'travelers': searchData.travelers,
        'type': searchData.type!.isEmpty ? 'one_way' : searchData.type,
      };

      if (searchData.departureDate != null) {
        requestBody['date'] = searchData.departureDate;
      }

      if (searchData.returnDate != null) {
        requestBody['return_date'] = searchData.returnDate;
      }

      final body = jsonEncode(requestBody);

      final response = await http.post(
        Uri.parse('https://bcknd.ticket-hub.net/user/booking'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Response data: $responseData');
        _searchResult = TripResponse.fromJson(responseData);
        notifyListeners();
      } else {
        log('Failed to search trips. Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
        showCustomSnackbar(
            context, 'Failed to search trips. Please try again.', false);
      }
    } catch (e) {
      log('Error searching trips: $e');
      showCustomSnackbar(context, 'Error searching trips: $e', false);
    }
  }

  Future<void> fetchCitiesandPaymentMethods() async {
    try {
      final response = await http.get(
        Uri.parse('https://bcknd.ticket-hub.net/user/booking/lists'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Cities cities = Cities.fromJson(responseData);
        _cities = cities.cities.map((x) => City.fromJson(x)).toList();
        PaymentMethods paymentMethods = PaymentMethods.fromJson(responseData);
        _paymentMethods = paymentMethods.paymentMethods
            .map((x) => PaymentMethod.fromJson(x))
            .toList();
        isCitiesLoaded = true;
        notifyListeners();
      } else {
        log('Failed to load cities. Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log('Error fetching cities: $e');
    }
  }

  List<Trip> getFilteredTrips(String vehicleType) {
    if (_searchResult == null) return [];

    switch (vehicleType) {
      case 'all':
        return _searchResult!.allTrips;
      case 'bus':
        return _searchResult!.busTrips;
      case 'hiace':
        return _searchResult!.hiaceTrips;
      case 'train':
        return _searchResult!.trainTrips;
      default:
        return _searchResult!.allTrips;
    }
  }

  Future<void> bookTrip(
    BuildContext context, {
    required int tripId,
    required int paymentMethodId,
    required double amount,
    File? receiptImage,
  }) async {
    final authServices = Provider.of<LoginProvider>(context, listen: false);
    final token = authServices.token;

    try {
      final uri =
          Uri.parse('https://bcknd.ticket-hub.net/user/booking/payment');
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      log('date: ${selectedTrip!.date}');
      request.fields['payment_method_id'] = paymentMethodId.toString();
      request.fields['trip_id'] = tripId.toString();
      request.fields['amount'] = amount.toString();
      request.fields['travel_date'] = selectedTrip!.date;
      request.fields['travelers'] = jsonEncode(searchData.travelers);

      for (int i = 0; i < chosenSeats.length; i++) {
        request.fields['seats[$i]'] = chosenSeats[i].toString();
      }

      final travellers = searchData.travelersList!;
      for (int i = 0; i < travellers.length; i++) {
        final travelerJson = travellers[i].toJson();
        travelerJson.forEach((key, value) {
          request.fields['travellers_data[$i][$key]'] = value.toString();
        });
      }

      if (receiptImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'receipt_image',
          receiptImage.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final resBody = await response.stream.bytesToString();
        // log('Response body: $resBody');
        if (resBody.contains('paymentLink')) {
          final String url = jsonDecode(resBody)['paymentLink'];
          final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => PaymentWebView(url: url)));
          if (!result) {
            showCustomSnackbar(context, 'Trip booked Successfully', true);
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (ctx) => const TabsScreen(selectedIndex: 1)),
              );
            });
          } else {
            showCustomSnackbar(context, 'Payment Failed', false);
          }
        } else {
          showCustomSnackbar(context, 'Trip booked Successfully', true);
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => const TabsScreen(selectedIndex: 1)),
            );
          });
        }
      } else {
        final resBody = await response.stream.bytesToString();
        log('Failed to book trip. Status code: ${response.statusCode}');
        log('Response body: $resBody');

        try {
          final decoded = jsonDecode(resBody);
          final errorMessage =
              decoded['errors'] ?? 'Booking failed. Please try again.';

          showCustomSnackbar(context, errorMessage.toString(), false);
        } catch (e) {
          showCustomSnackbar(
              context, 'Booking failed. Please try again.', false);
        }
      }
    } catch (e) {
      log('Error booking trip: $e');
      showCustomSnackbar(context, 'An unexpected error occurred.', false);
    }
  }
}
