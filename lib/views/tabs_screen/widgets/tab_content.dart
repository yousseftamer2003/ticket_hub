import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/controller/booking_controller.dart';

class TabContent extends StatefulWidget {
  const TabContent({super.key});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  int travelers = 1;
  String? selectedDeparture;
  String? selectedArrival;
  String selectedDate = "Select Date";

  Future<void> _selectDate(BuildContext context) async {
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
        selectedDate = "${picked.day}/${picked.month}/${picked.year}";
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
            onPressed: () {},
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
                  const Text('Private', style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildDropdownCard('Departure From', selectedDeparture, (value) {
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
                child: _buildDropdownCard('Arrival To', selectedArrival, (value) {
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

          _buildDateCard(),

          const SizedBox(height: 10),

          _buildTravelersCounter(),
        ],
      ),
    );
  }

  Widget _buildDropdownCard(String title, String? selectedValue, Function(String?) onChanged) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
        final isCitiesLoaded = bookingProvider.isCitiesLoaded;
        final cities = bookingProvider.cities;
        List<String> citiesNames = cities.map((city) => city.name).toList();

        // Remove selected city from the other dropdown list
        List<String> filteredCities = List.from(citiesNames);
        if (title == 'Departure From' && selectedArrival != null) {
          filteredCities.remove(selectedArrival);
        } else if (title == 'Arrival To' && selectedDeparture != null) {
          filteredCities.remove(selectedDeparture);
        }

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[600])),

                isCitiesLoaded
                    ? DropdownButton<String>(
                        value: selectedValue,
                        isExpanded: true,
                        underline: Container(height: 2, color: Colors.orange),
                        items: filteredCities
                            .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                            .toList(),
                        hint: const Text('Select a city'),
                        onChanged: onChanged,
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
    return const CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(Icons.compare_arrows, color: Colors.orange),
    );
  }

  // Travel Date Picker
  Widget _buildDateCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: const Icon(Icons.calendar_month, color: Colors.orange),
        title: Text('Travel Date', style: TextStyle(color: Colors.grey[600])),
        subtitle: Text(selectedDate, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: () => _selectDate(context),
      ),
    );
  }

  // Travelers Counter
  Widget _buildTravelersCounter() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number Of Travelers', style: TextStyle(color: Colors.grey[600])),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (travelers > 1) {
                      setState(() => travelers--);
                    }
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.grey),
                ),
                Text('$travelers', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => travelers++),
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
