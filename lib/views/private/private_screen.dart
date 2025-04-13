import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/controller/private/private_list_provider.dart';
import 'package:ticket_hub/model/private/private_model.dart';
import 'package:ticket_hub/views/private/widget/cart_widget.dart';
import 'package:ticket_hub/views/tabs_screen/screens/tabs_screen.dart';

import '../../generated/l10n.dart' show S;

class PrivateScreen extends StatefulWidget {
  const PrivateScreen({super.key});

  @override
  State<PrivateScreen> createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  final TextEditingController _addressFromController = TextEditingController();
  final TextEditingController _addressToController = TextEditingController();
  String? _selectedDate;
  int _travelers = 1;
  City? _selectedCityFrom;
  City? _selectedCityTo;
  Brand? _selectedCar;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final carProvider = Provider.of<CarProvider>(context, listen: false);
    await carProvider.fetchData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: customAppBar(
        context,
        S.of(context).private_booking,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownCard(
                      title: S.of(context).select_a_city,
                      items: carProvider.cities.map((e) => e.name).toList(),
                      hint: S.of(context).select_city_hint,
                      selectedValue: _selectedCityFrom?.name,
                      onChanged: (value) {
                        setState(() {
                          _selectedCityFrom = carProvider.cities
                              .firstWhere((city) => city.name == value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldCard(
                      title: S.of(context).address_from,
                      controller: _addressFromController,
                      hintText: S.of(context).address_from_hint,
                    ),
                    const SizedBox(height: 10),
                    DropdownCard(
                      title: S.of(context).select_city_to,
                      items: carProvider.cities.map((e) => e.name).toList(),
                      hint: S.of(context).select_a_city,
                      selectedValue: _selectedCityTo?.name,
                      onChanged: (value) {
                        setState(() {
                          _selectedCityTo = carProvider.cities
                              .firstWhere((city) => city.name == value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldCard(
                      title: S.of(context).address_to,
                      controller: _addressToController,
                      hintText: S.of(context).address_to_hint,
                    ),
                    const SizedBox(height: 10),
                    DropdownCard(
                      title: S.of(context).select_car_brand,
                      items: carProvider.brands.map((e) => e.name).toList(),
                      hint: S.of(context).select_car_brand_hint,
                      selectedValue: _selectedCar?.name,
                      onChanged: (value) {
                        setState(() {
                          _selectedCar = carProvider.brands
                              .firstWhere((brand) => brand.name == value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    DateCard(
                      title: S.of(context).select_date,
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TravelersCounter(
                      onChanged: (value) {
                        setState(() {
                          _travelers = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    DarkCustomButton(
                      text: S.of(context).book_button,
                      onPressed: () async {
                        await _submitBooking(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _submitBooking(BuildContext context) async {
    final carProvider = Provider.of<CarProvider>(context, listen: false);

    bool success = await carProvider.sendBookingRequest(
      context: context,
      date: _selectedDate!,
      traveler: _travelers,
      cityId: _selectedCityTo!.id,
      address: _addressToController.text,
      carId: _selectedCar!.id,
      fromCityId: _selectedCityFrom!.id,
      fromAddress: _addressFromController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).booking_successful)),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const TabsScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).booking_failed,
        )),
      );
    }
  }
}
