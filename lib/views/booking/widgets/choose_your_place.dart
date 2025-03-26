import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/colors.dart';

class ChooseYourPlace extends StatefulWidget {
  const ChooseYourPlace({super.key});

  @override
  State<ChooseYourPlace> createState() => _ChooseYourPlaceState();
}

class _ChooseYourPlaceState extends State<ChooseYourPlace> {
  int? selectedSeat;

  final List<int> availableSeats = [1, 2, 3, 4, 7, 10, 11, 12, 13, 14];
  final List<int> unavailableSeats = [5, 6, 8, 9];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                'assets/images/swa2.png', // Replace with your actual image asset
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 16),
              _buildSeat(1),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSeat(2), _buildSeat(3), _buildSeat(4),
              const SizedBox(width: 40), // Space for aisle
              _buildSeat(7),
              _buildSeat(5), _buildSeat(6),
              const SizedBox(width: 40), // Space for aisle
              _buildSeat(10),
              _buildSeat(8), _buildSeat(9),
              const SizedBox(width: 40), // Space for aisle
              _buildSeat(11),
              _buildSeat(12), _buildSeat(13), _buildSeat(14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeat(int seatNumber) {
    bool isSelected = seatNumber == selectedSeat;
    bool isAvailable = availableSeats.contains(seatNumber);
    bool isUnavailable = unavailableSeats.contains(seatNumber);

    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() {
                selectedSeat = seatNumber;
              });
            }
          : null,
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? orangeColor
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
