import 'package:flutter/material.dart';
import 'package:ticket_hub/views/booking/screens/bus_details_screen.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({super.key,required this.busNumber, required this.price, required this.availableSeats, required this.departureTime, required this.arrivalTime, required this.departureStation, required this.arrivalStation, required this.isCheapest});
  final String busNumber;
  final int price;
  final int availableSeats;
  final String departureTime;
  final String arrivalTime;
  final String departureStation;
  final String arrivalStation;
  final bool isCheapest;

  @override
  Widget build(BuildContext context) {
    DateTime departure = DateTime.parse("2024-01-01 $departureTime");
    DateTime arrival = DateTime.parse("2024-01-01 $arrivalTime");

    Duration duration = arrival.difference(departure);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/bus_result_image.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bus($busNumber)",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$hours h $minutes m",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          "Cairo Express",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        Text(
                          "4.8 (86)",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          departureStation,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          arrivalStation,
                          style: const TextStyle(
                            fontSize: 11,
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "From \$$price / Person",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("$availableSeats available seats", style: const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 8),
              isCheapest? Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text("Cheapest", style: TextStyle(fontSize: 14)),
                ),
              ) : const SizedBox(),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx)=> const TabViewScreen()),
                  );
                },
                child: const Text(
                  "Select",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
