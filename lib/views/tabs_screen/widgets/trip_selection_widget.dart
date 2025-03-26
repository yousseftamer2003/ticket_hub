import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/booking_controller.dart';

class TripSelectionWidget extends StatefulWidget {
  const TripSelectionWidget({super.key});

  @override
  State<TripSelectionWidget> createState() => _TripSelectionWidgetState();
}

class _TripSelectionWidgetState extends State<TripSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingController>(
      builder: (context, booking, _) {
        return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: "one_way",
              groupValue: booking.searchData.type,
              onChanged: (value) {
                  booking.setTripType(value!);
              },
              activeColor: Colors.orange,
            ),
            const Text(
              "One-Way",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 20),
            Radio<String>(
              value: "Round-Trip",
              groupValue: booking.searchData.type,
              onChanged: (value) {
                booking.setTripType(value!);
              },
              activeColor: Colors.orange,
            ),
            const Text(
              "Round-Trip",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
      },
    );
  }
}