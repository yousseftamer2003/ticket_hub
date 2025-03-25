import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/home_header_widget.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/tab_content.dart';
import 'package:ticket_hub/views/tabs_screen/widgets/trip_selection_widget.dart';

enum MenuItem { all, hiace, bus, train }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedContent() {
    return const TabContent();
  }

  @override
  void initState() {
    Provider.of<BookingController>(context, listen: false)
        .fetchCitiesandPaymentMethods(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          const HomeHeaderWidget(), // Background Header
          /// Menu Bar (Responsive)
          Positioned(
            top: screenHeight * 0.21,
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
                            horizontal: screenWidth * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              menuItem.name.toUpperCase(),
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

          /// Trip Selection Widget (Centered)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.30),
              child: const TripSelectionWidget(),
            ),
          ),

          /// Tab Content Section (Below Trip Selection)
          Positioned(
            top: screenHeight * 0.36,
            left: 0,
            right: 0,
            child: _getSelectedContent(),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: DarkCustomButton(text: 'Search', onPressed: (){}),
            )
        ],
      ),
    );
  }
}
