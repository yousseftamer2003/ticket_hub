import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_hub/constant/colors.dart';

class TabContent extends StatefulWidget {
  const TabContent({super.key});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  int travelers = 1;
  String selectedDate = '12/5/2024'; // Default selected date
  String departure = 'Alexandria';
  String arrival = 'Cairo';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/smallCar.svg'),
                  const SizedBox(width: 10),
                  const Text('Private', style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildDropdownCard('Departure From', departure),
              ),
              const SizedBox(width: 10),
              _buildSwapIcon(),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdownCard('Arrival To', arrival),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildDateCard(),

          const SizedBox(height: 20),

          _buildTravelersCounter(),
        ],
      ),
    );
  }

  Widget _buildDropdownCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[600])),
            DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: Container(height: 2, color: Colors.orange),
              items: ['Alexandria', 'Cairo', 'Giza', 'Aswan', 'Luxor']
                  .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  if (title == 'Departure From') {
                    departure = newValue!;
                  } else {
                    arrival = newValue!;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Swap Icon
  Widget _buildSwapIcon() {
    return const CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(Icons.compare_arrows, color: Colors.orange),
    );
  }

  // Travel Date Picker
  Widget _buildDateCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: const Icon(Icons.calendar_month, color: Colors.orange),
        title: Text('Travel Date', style: TextStyle(color: Colors.grey[600])),
        subtitle: Text(selectedDate, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2024, 5, 12),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );
          if (picked != null) {
            setState(() {
              selectedDate = "${picked.day}/${picked.month}/${picked.year}";
            });
          }
        },
      ),
    );
  }

  // Travelers Counter
  Widget _buildTravelersCounter() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number Of Travelers', style: TextStyle(color: Colors.grey[600])),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (travelers > 1) {
                      setState(() => travelers--);
                    }
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.grey),
                ),
                Text('$travelers', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => travelers++),
                  icon: const Icon(Icons.add_circle, color: Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
