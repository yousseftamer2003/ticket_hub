import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_snack_bar.dart';
import 'package:ticket_hub/controller/booking_controller.dart';
import 'package:ticket_hub/views/booking/screens/book_screen.dart';

class ChooseYourPlace extends StatefulWidget {
  const ChooseYourPlace({super.key});

  @override
  State<ChooseYourPlace> createState() => _ChooseYourPlaceState();
}

class _ChooseYourPlaceState extends State<ChooseYourPlace> {
  int? selectedSeat;

  final List<int> availableSeats = [1, 2, 3, 4, 7, 10, 11, 12, 13, 14];
  final List<int> unavailableSeats = [5, 6, 8, 9];

  void _toggleSeatSelection(int seatNumber) {
    setState(() {
      if (selectedSeat == seatNumber) {
        selectedSeat = null; 
      } else {
        selectedSeat = seatNumber; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: selectedSeat != null
          ? Consumer<BookingController>(
            builder: (context, value, _) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: DarkCustomButton(
                  text: "Continue",
                  onPressed: () {
                    if(value.searchData.travelersList![0].name != '' && value.searchData.travelersList![0].age != ''){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const BookScreen()));
                    }else{
                      showCustomSnackbar(context, 'Please fill Travelers data', false);
                    }
                  },
                ),
              );
            },
          )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select An Available Seat",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  'assets/images/swa2.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 16),
                _buildSeat(1),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSeat(2),
                const SizedBox(width: 8),
                _buildSeat(3),
                const SizedBox(width: 8),
                _buildSeat(4),
                const Spacer(),
                _buildSeat(7),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildSeat(5),
                const SizedBox(width: 8),
                _buildSeat(6),
                const Spacer(),
                _buildSeat(10),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildSeat(8),
                const SizedBox(width: 8),
                _buildSeat(9),
                const Spacer(),
                _buildSeat(11),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildSeat(12),
                const SizedBox(width: 8),
                _buildSeat(13),
                const SizedBox(width: 8),
                _buildSeat(14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeat(int seatNumber) {
    bool isSelected = seatNumber == selectedSeat;
    bool isAvailable = availableSeats.contains(seatNumber);
    bool isUnavailable = unavailableSeats.contains(seatNumber);

    return GestureDetector(
      onTap: isAvailable ? () => _toggleSeatSelection(seatNumber) : null,
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.orange
              : (isUnavailable ? Colors.grey[300] : Colors.white),
          border: Border.all(
            color: isUnavailable ? Colors.grey : Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "$seatNumber",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isUnavailable ? Colors.grey[600] : Colors.black,
          ),
        ),
      ),
    );
  }
}
