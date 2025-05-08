import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_snack_bar.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/views/booking/screens/search_result_screen.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/home_header_widget.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/tab_content.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/trip_selection_widget.dart';
import 'package:ticket_hub/generated/l10n.dart' show S;

enum MenuItem { all, hiace, bus, train }

extension MenuItemExtension on MenuItem {
  String localizedName(BuildContext context) {
    final s = S.of(context);
    switch (this) {
      case MenuItem.all:
        return s.all;
      case MenuItem.hiace:
        return s.Hiace;
      case MenuItem.bus:
        return s.Bus;
      case MenuItem.train:
        return s.train;
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  MenuItem _selectedVehicleType = MenuItem.all;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedVehicleType = MenuItem.values[index];
      
      // Update trip type in the booking controller
      final String tripType;
      switch (_selectedVehicleType) {
        case MenuItem.all:
          tripType = "all";
          break;
        case MenuItem.hiace:
          tripType = "hiace";
          break;
        case MenuItem.bus:
          tripType = "bus";
          break;
        case MenuItem.train:
          tripType = "train";
          break;
      }
      Provider.of<BookingController>(context, listen: false).setTripType(tripType);
    });
  }

  @override
  void initState() {
    Provider.of<BookingController>(context, listen: false)
        .fetchCitiesandPaymentMethods();
    // Set default trip type to "all"
    Provider.of<BookingController>(context, listen: false).setTripType("all");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          const HomeHeaderWidget(),
          Positioned(
            top: screenHeight * 0.19,
            left: screenWidth * 0.04,
            child: SizedBox(
              width: screenWidth * 0.92,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(MenuItem.values.length, (index) {
                      final menuItem = MenuItem.values[index];
                      final bool isSelected = _selectedIndex == index;

                      return GestureDetector(
                        onTap: () => _onItemTapped(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.064,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              menuItem.localizedName(context),
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.28),
              child: const TripSelectionWidget(),
            ),
          ),
          Positioned(
            top: screenHeight * 0.34,
            left: 0,
            right: 0,
            child: const TabContent(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DarkCustomButton(
                text: S.of(context).Search,
                onPressed: () async {
                  final booking =
                      Provider.of<BookingController>(context, listen: false);
                  if (booking.searchData.departureStation != null &&
                      booking.searchData.arrivalStation != null && 
                      booking.searchData.departureDate != null) {
                    await booking.searchTrips(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SearchResultScreen(
                          departureFrom: booking.searchData.departureStation!,
                          arrivalTo: booking.searchData.arrivalStation!,
                          selectedVehicleType: _selectedVehicleType,
                        ),
                      ),
                    );
                  } else {
                    showCustomSnackbar(context, 'Please fill all the fields', false);
                  }
                }),
          )
        ],
      ),
    );
  }
}