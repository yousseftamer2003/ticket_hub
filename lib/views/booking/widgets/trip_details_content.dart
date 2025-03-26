import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/booking_controller.dart';

class TripDetailsContent extends StatelessWidget {
  const TripDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amenities On Board
              const Text(
                "Amenities On Board:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildAmenityItem("assets/images/ac.svg", "A/C"), // Replace with your asset path
                  const SizedBox(width: 16),
                  _buildAmenityItem("assets/images/ac.svg", "WC"),
                ],
              ),
              
              const SizedBox(height: 20),

              // Useful Info
              const Text(
                "Useful Info",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Luggage Policy
              const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey), 
                  SizedBox(width: 8),
                  Text(
                    "Luggage Policy:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Text(
                  "Each Passenger Is Allowed One 25 Kg Bag And One Handbag.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmenityItem(String iconPath, String label) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 24, height: 24), // Icon
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
