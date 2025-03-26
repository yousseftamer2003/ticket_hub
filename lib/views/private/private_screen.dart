import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/controller/private/private_list_provider.dart';
import 'package:ticket_hub/model/private/private_model.dart';
import 'package:ticket_hub/views/private/widget/cart_widget.dart';
import 'package:ticket_hub/views/tabs_screen/screens/tabs_screen.dart';

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
  Country? _selectedCountry;
  City? _selectedCityFrom;
  City? _selectedCityTo;
  Car? _selectedCar;
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final carProvider = Provider.of<CarProvider>(context, listen: false);
    await carProvider.fetchData(); // Ensure you have a method that fetches data
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: customAppBar(context, 'Private Booking'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownCard(
                            title: "Which country are you from?",
                            items: carProvider.countries
                                .map((e) => e.name)
                                .toList(),
                            hint: "Select country",
                            selectedValue: _selectedCountry?.name,
                            onChanged: (value) {
                              setState(() {
                                _selectedCountry = carProvider.countries
                                    .firstWhere(
                                        (country) => country.name == value);
                                _selectedCityFrom = null;
                                _selectedCityTo = null;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownCard(
                            title: "Which city are you from?",
                            items: carProvider.cities
                                .where((city) =>
                                    city.countryId == _selectedCountry?.id)
                                .map((e) => e.name)
                                .toList(),
                            hint: "Select your city",
                            selectedValue: _selectedCityFrom?.name,
                            onChanged: (value) {
                              setState(() {
                                _selectedCityFrom = carProvider.cities
                                    .firstWhere((city) => city.name == value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFieldCard(
                      title: "Address From",
                      controller: _addressFromController,
                      hintText: "Enter your address",
                    ),
                    const SizedBox(height: 10),
                    DropdownCard(
                      title: "Which city are you going to?",
                      items: carProvider.cities
                          .where(
                              (city) => city.countryId == _selectedCountry?.id)
                          .map((e) => e.name)
                          .toList(),
                      hint: "Select your city",
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
                      title: "Address To",
                      controller: _addressToController,
                      hintText: "Enter your destination",
                    ),
                    const SizedBox(height: 10),
                    DropdownCard(
                      title: 'Which car type?',
                      items: carProvider.cars
                          .map((car) => car.category.name)
                          .toSet()
                          .toList(),
                      hint: 'Select car type',
                      selectedValue: _selectedCar?.category.name,
                      onChanged: (value) {
                        setState(() {
                          _selectedCar = carProvider.cars
                              .firstWhere((car) => car.category.name == value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    DateCard(
                      title: 'Select Date',
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
                      text: 'Book',
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

    print('Sending Booking Request:');
    print('Date: ${_selectedDate}');
    print('Travelers: $_travelers');
    print('Country ID: ${_selectedCountry?.id}');
    print('From City ID: ${_selectedCityFrom?.id}');
    print('From Address: ${_addressFromController.text}');
    print('To City ID: ${_selectedCityTo?.id}');
    print('To Address: ${_addressToController.text}');
    print('Car ID: ${_selectedCar?.id}');

    bool success = await carProvider.sendBookingRequest(
      context: context,
      date: _selectedDate!,
      traveler: _travelers,
      countryId: _selectedCountry!.id,
      cityId: _selectedCityTo!.id,
      address: _addressToController.text,
      carId: _selectedCar!.id,
      fromCityId: _selectedCityFrom!.id,
      fromAddress: _addressFromController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successful!')
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const TabsScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking failed. Try again later.')),
      );
    }
  }
}
