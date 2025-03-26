import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/views/booking/widgets/result_container.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, required this.departureFrom, required this.arrivalTo});
  final String departureFrom;
  final String arrivalTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Result'),
      body: Consumer<BookingController>(
        builder: (context, bookingProvider, _) {
          final results = bookingProvider.searchResult!.allTrips;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(departureFrom, style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500)),
                      SvgPicture.asset('assets/images/toooo.svg'),
                      Text(arrivalTo, style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Select your trip:', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500)),
                const SizedBox(height: 15,),
                ...List.generate(results.length, 
                (index){
                  final result = results[index];
                  int minPrice = results.map((result) => result.price).reduce((a, b) => a < b ? a : b);
                  return ResultContainer(
                    arrivalStation: result.dropoffStation.name,
                    arrivalTime: result.arrivalTime,
                    availableSeats: result.availableSeats,
                    busNumber: result.bus.busNumber,
                    departureStation: result.pickupStation.name,
                    departureTime: result.departureTime,
                    price: result.price,
                    isCheapest: result.price == minPrice,
                  );
                }
                ),
              ]
            ),
          );
        },
        )
    );
  }
}