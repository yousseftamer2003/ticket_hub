import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/booking_controller.dart';

class YourRideContent extends StatelessWidget {
  const YourRideContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Ride Content',style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10,),
            const Text('Departure Time: ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey)),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black,width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/images/calendar.svg'),
                  const SizedBox(width: 8),
                  Text('${bookingProvider.searchData.departureDate}',style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            if(bookingProvider.searchData.returnDate != null)  ...[
              const Text('return Time: ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey)),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black,width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/images/calendar.svg'),
                  const SizedBox(width: 8),
                  Text('${bookingProvider.searchData.departureDate}',style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            ]
          ],
        ),
      );
      },
    );
  }
}