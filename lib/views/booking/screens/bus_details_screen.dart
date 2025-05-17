import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/views/booking/widgets/choose_your_place.dart';
import 'package:ticket_hub/views/booking/widgets/trip_details_content.dart';
import 'package:ticket_hub/views/booking/widgets/your_ride_content.dart';

class TabViewScreen extends StatelessWidget {
  const TabViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bookingController = Provider.of<BookingController>(context);
    final selectedTrip = bookingController.selectedTrip;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    selectedTrip?.bus?.imageLink ?? '',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: orangeColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: const TabBar(
                  isScrollable: true,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.orange,
                  tabs: [
                    Tab(text: "Your Ride"),
                    Tab(text: "Trip Details"),
                    Tab(text: "Choose your place"),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    YourRideContent(),
                    TripDetailsScreen(),
                    ChooseYourPlace(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
