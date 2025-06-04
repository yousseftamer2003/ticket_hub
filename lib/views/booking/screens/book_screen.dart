import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_snack_bar.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/controller/image_controller.dart';
import 'package:ticket_hub/views/auth/login_screen.dart';

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
      body: Consumer2<BookingController, ImageController>(
        builder: (context, bookingProvider, imageController, _) {
          final paymentMethods = bookingProvider.paymentMethods;
          final selectedTrip = bookingProvider.selectedTrip;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                  const SizedBox(height: 20),
                  Text(
                    "Total Booking: ${selectedTrip.price} EGP",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                  if (_selectedPaymentMethod != 'Visa Card' &&
                      _selectedPaymentMethod != null) ...[
                    const SizedBox(height: 20),
                    const Text(
                      "Upload Payment Receipt",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => imageController.pickImageFromGallery(),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: imageController.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(imageController.imageFile!,
                                    fit: BoxFit.cover),
                              )
                            : const Center(
                                child: Text("Tap to upload receipt image")),
                      ),
                    ),
                  ],
                  DarkCustomButton(
                    text: 'Book Now',
                    onPressed: () {
                      final authProvider =
                          Provider.of<LoginProvider>(context, listen: false);
                      if (authProvider.isUserAuthenticated()) {
                        if (_selectedPaymentMethodId != null) {
                          if (_selectedPaymentMethod == "Visa Card") {
                            bookingProvider.bookTrip(
                              context,
                              tripId: selectedTrip.id,
                              paymentMethodId: _selectedPaymentMethodId!,
                              amount: selectedTrip.price,
                            );
                          } else {
                            if (imageController.base64Image == null) {
                              showCustomSnackbar(context,
                                  'Please upload a receipt image', false);
                              return;
                            }
                            bookingProvider.bookTrip(
                              context,
                              tripId: selectedTrip.id,
                              paymentMethodId: _selectedPaymentMethodId!,
                              amount: selectedTrip.price,
                              receiptImage: imageController.imageFile!,
                            );
                            imageController.clearImage();
                          }
                        } else {
                          showCustomSnackbar(
                            context,
                            'Please select payment method',
                            false,
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Login Required"),
                            content:
                                const Text("You need to log in to proceed."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) => const LoginScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: orangeColor,
                                    foregroundColor: Colors.white),
                                child: const Text("Login"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
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
      color: Colors.white,
      child: RadioListTile<String>(
        activeColor: orangeColor,
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value;
            _selectedPaymentMethodId = id;
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
