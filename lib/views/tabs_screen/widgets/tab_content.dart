import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/views/private/private_screen.dart';

class TabContent extends StatefulWidget {
  const TabContent({super.key});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  String? selectedDeparture;
  String? selectedArrival;

  Future<void> _selectDate(BuildContext context) async {
    final booking = Provider.of<BookingController>(context, listen: false);
    DateTime today = DateTime.now();
    DateTime firstDate = today;
    DateTime lastDate = DateTime(today.year + 5);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: orangeColor, // ✅ Header & button color
              onPrimary: Colors.white, // ✅ Text color on primary
              surface: Colors.white, // ✅ Background color
              onSurface: blackColor, // ✅ Text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: orangeColor, // ✅ OK & Cancel color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        booking.searchData.departureDate =
            "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final booking = Provider.of<BookingController>(context, listen: false);
    DateTime today = DateTime.now();

    // Ensure departureDate is formatted correctly
    String formattedDate;
    try {
      formattedDate = DateFormat('yyyy-MM-dd').format(
          DateFormat('yyyy-M-d').parse(booking.searchData.departureDate!));
    } catch (e) {
      log("Date parsing error: $e");
      return;
    }

    DateTime firstDate = DateTime.parse(formattedDate);
    DateTime lastDate = DateTime(today.year + 5);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: orangeColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: orangeColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        booking.searchData.returnDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const PrivateScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/smallCar.svg'),
                  const SizedBox(width: 10),
                  const Text('Private',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildDropdownCard('Departure From', selectedDeparture,
                    (value) {
                  setState(() {
                    selectedDeparture = value;
                    if (selectedArrival == value) {
                      selectedArrival = null;
                    }
                  });
                }),
              ),
              const SizedBox(width: 10),
              _buildSwapIcon(),
              const SizedBox(width: 10),
              Expanded(
                child:
                    _buildDropdownCard('Arrival To', selectedArrival, (value) {
                  setState(() {
                    selectedArrival = value;
                    if (selectedDeparture == value) {
                      selectedDeparture = null;
                    }
                  });
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Consumer<BookingController>(builder: (context, bookingProvider, _) {
            if (bookingProvider.searchData.type == 'one_way') {
              return _buildDateCard();
            } else {
              return Row(
                children: [
                  Expanded(child: _buildDateCard()),
                  const SizedBox(width: 10),
                  Expanded(child: _buildReturnDateCard()),
                ],
              );
            }
          }),
          const SizedBox(height: 10),
          _buildTravelersCounter(),
        ],
      ),
    );
  }

  Widget _buildDropdownCard(
      String title, String? selectedValue, Function(String?) onChanged) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
        final isCitiesLoaded = bookingProvider.isCitiesLoaded;
        final cities = bookingProvider.cities;

        final Map<String, int> cityMap = {
          for (var city in cities) city.name: city.id
        };

        List<String> cityNames = cityMap.keys.toList();

        List<String> filteredCities = List.from(cityNames);
        if (title == 'Departure From' && selectedArrival != null) {
          filteredCities.remove(selectedArrival);
        } else if (title == 'Arrival To' && selectedDeparture != null) {
          filteredCities.remove(selectedDeparture);
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[300],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[600],fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,),
                isCitiesLoaded
                    ? DropdownButton<String>(
                        value: selectedValue,
                        isExpanded: true,
                        underline: Container(height: 2, color: Colors.orange),
                        items: filteredCities
                            .map((city) => DropdownMenuItem(
                                value: city, child: Text(city)))
                            .toList(),
                        hint: const Text('Select a city',style: TextStyle(fontSize: 12),),
                        onChanged: (newValue) {
                          setState(() {
                            if (title == 'Departure From') {
                              selectedDeparture = newValue;
                              bookingProvider.searchData.departureFromId =
                                  cityMap[newValue]!;
                              bookingProvider.searchData.departureStation =
                                  newValue;
                            } else {
                              selectedArrival = newValue;
                              bookingProvider.searchData.arrivalToId =
                                  cityMap[newValue]!;
                              bookingProvider.searchData.arrivalStation =
                                  newValue;
                            }
                          });
                        },
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Swap Icon
  Widget _buildSwapIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          final booking =
              Provider.of<BookingController>(context, listen: false);

          String? tempCity = selectedDeparture;
          selectedDeparture = selectedArrival;
          selectedArrival = tempCity;

          int? tempCityId = booking.searchData.departureFromId;
          booking.searchData.departureFromId = booking.searchData.arrivalToId;
          booking.searchData.arrivalToId = tempCityId;
        });
      },
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(Icons.compare_arrows, color: Colors.orange),
      ),
    );
  }

  // Travel Date Picker
  Widget _buildDateCard() {
    final booking = Provider.of<BookingController>(context, listen: false);
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.orange),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Travel Date',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking.searchData.departureDate ?? 'Select Date',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReturnDateCard() {
    final booking = Provider.of<BookingController>(context, listen: false);
    return GestureDetector(
      onTap: () => _selectReturnDate(context),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.orange),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Return Date',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking.searchData.returnDate ?? 'Select Return Date',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // Travelers Counter
  Widget _buildTravelersCounter() {
    final booking = Provider.of<BookingController>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number Of Travelers',
                style: TextStyle(color: Colors.grey[600])),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (booking.searchData.travelers! > 1) {
                      setState(() {
                        booking.searchData.travelers =
                            booking.searchData.travelers! - 1;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.grey),
                ),
                Text('${booking.searchData.travelers!}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      booking.searchData.travelers =
                          booking.searchData.travelers! + 1;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
