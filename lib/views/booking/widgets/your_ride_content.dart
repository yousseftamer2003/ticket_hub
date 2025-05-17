import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart'; // Import for the button
import 'package:ticket_hub/constant/widgets/custom_snack_bar.dart'; // Import for validation feedback
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/model/booking/search_data.dart';

class YourRideContent extends StatefulWidget {
  const YourRideContent({super.key});

  @override
  State<YourRideContent> createState() => _YourRideContentState();
}

class _YourRideContentState extends State<YourRideContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookingProvider =
          Provider.of<BookingController>(context, listen: false);
      final travelersCount = bookingProvider.searchData.travelers ?? 0;
      bookingProvider.searchData.travelersList ??= List.generate(
        travelersCount,
        (index) => Traveler(name: '', age: ''),
      );
    });
  }

  // Function to validate traveler information
  bool _validateTravelers(List<Traveler>? travelers) {
    if (travelers == null || travelers.isEmpty) {
      return false;
    }

    return !travelers.any((traveler) =>
        traveler.name == null ||
        traveler.name!.isEmpty ||
        traveler.age == null ||
        traveler.age!.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
        final travelersCount = bookingProvider.searchData.travelers ?? 0;
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DarkCustomButton(
              text: "Continue to Select Seats",
              onPressed: () {
                // Validate traveler information before proceeding
                if (_validateTravelers(
                    bookingProvider.searchData.travelersList)) {
                  // Navigate to the third tab (Choose your place)
                  DefaultTabController.of(context).animateTo(2);
                } else {
                  // Show error message if validation fails
                  showCustomSnackbar(
                      context,
                      'Please fill in all traveler information before continuing',
                      false);
                }
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Ride Content',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  const Text(
                    'Departure Date and Time:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/images/calendar.svg'),
                            const SizedBox(width: 8),
                            Text('${bookingProvider.searchData.departureDate}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.timer_outlined),
                            const SizedBox(width: 8),
                            Text(bookingProvider.selectedTrip!.departureTime,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Arrival Time:',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined),
                        const SizedBox(width: 8),
                        Text(bookingProvider.selectedTrip!.arrivalTime,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (bookingProvider.searchData.returnDate != null) ...[
                    const Text(
                      'Return Time:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/calendar.svg'),
                          const SizedBox(width: 8),
                          Text('${bookingProvider.searchData.returnDate}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  const Text(
                    'Travelers:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(travelersCount, (index) {
                    bookingProvider.searchData.travelersList ??= List.generate(
                      travelersCount,
                      (i) => Traveler(name: '', age: ''),
                    );
                    while (bookingProvider.searchData.travelersList!.length <=
                        index) {
                      bookingProvider.searchData.travelersList!
                          .add(Traveler(name: '', age: ''));
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 6,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                gradient: LinearGradient(
                                  colors: [
                                    orangeColor,
                                    Color.fromARGB(255, 247, 217, 191)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Traveler ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    initialValue: bookingProvider
                                        .searchData.travelersList![index].name,
                                    decoration: const InputDecoration(
                                      labelText: 'Full Name',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      bookingProvider.searchData
                                          .travelersList![index].name = value;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    initialValue: bookingProvider
                                        .searchData.travelersList![index].age,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Age',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      bookingProvider.searchData
                                          .travelersList![index].age = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
