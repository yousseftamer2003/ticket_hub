import 'package:flutter/material.dart';

class TripSelectionWidget extends StatefulWidget {
  const TripSelectionWidget({super.key});

  @override
  State<TripSelectionWidget> createState() => _TripSelectionWidgetState();
}

class _TripSelectionWidgetState extends State<TripSelectionWidget> {
  String _selectedTrip = "One-Way";

  @override
  Widget build(BuildContext context) {
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
            value: "One-Way",
            groupValue: _selectedTrip,
            onChanged: (value) {
              setState(() {
                _selectedTrip = value!;
              });
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
            groupValue: _selectedTrip,
            onChanged: (value) {
              setState(() {
                _selectedTrip = value!;
              });
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
  }
}