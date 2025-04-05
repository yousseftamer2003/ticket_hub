import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_snack_bar.dart';
import 'package:ticket_hub/controller/booking_controller.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  String? _selectedPaymentMethod;
  int? _selectedPaymentMethodId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Pay'),
      body: Consumer<BookingController>(
        builder: (context, bookingProvider, _) {
          final paymentMethods = bookingProvider.paymentMethods;
          final selectedTrip = bookingProvider.selectedTrip;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Trip Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: Card(
                    color: Colors.grey[200],
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTripDetailRow(Icons.monetization_on,
                              "Ticket Price: ${selectedTrip!.price} EGP"),
                          _buildTripDetailRow(Icons.calendar_today,
                              "Thursday, ${selectedTrip.date}"),
                          _buildTripDetailRow(
                              Icons.access_time, selectedTrip.departureTime),
                          _buildTripDetailRow(Icons.location_on,
                              "${selectedTrip.pickupStation.name}, ${selectedTrip.dropoffStation.name}"),
                          _buildTripDetailRow(Icons.location_on,
                              "To: ${bookingProvider.searchData.departureStation}, ${bookingProvider.searchData.arrivalStation}"),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  "Total Booking: ${selectedTrip.price} EGP",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Discount Coupon",
                    prefixIcon: Icon(Icons.local_offer),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Choose Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...paymentMethods.map(
                    (method) => _buildPaymentOption(method.name, method.id)),
                const SizedBox(height: 20),
                DarkCustomButton(
                  text: 'Book Now',
                  onPressed: () {
                    if (_selectedPaymentMethodId != null) {
                      bookingProvider.bookTrip(
                        context,
                        tripId: selectedTrip.id,
                        paymentMethodId:
                            _selectedPaymentMethodId!, 
                        amount: selectedTrip.price,
                      );
                      showCustomSnackbar(context, 'Trip booked Successfully', true);
                    } else {
                      showCustomSnackbar(context, 'Please select payment method', false);
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: orangeColor, size: 20),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }

  Widget _buildPaymentOption(String title, int id) {
    return Card(
      child: RadioListTile<String>(
        activeColor: orangeColor,
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value;
            _selectedPaymentMethodId = id; // Assign selected payment method ID
          });
        },
        title: Row(
          children: [
            const Icon(Icons.payment, color: orangeColor),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
