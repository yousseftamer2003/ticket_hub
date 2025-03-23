import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/colors.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  MyTripsPageState createState() => MyTripsPageState();
}

class MyTripsPageState extends State<MyTripsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, 2))
            ],
          ),
          margin: const EdgeInsets.all(16),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab, // Ensures full tab color
            indicator: BoxDecoration(
              color: orangeColor,
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Previous"),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTripsList(),
              _buildTripsList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTripsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildTripCard();
      },
    );
  }

  Widget _buildTripCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "#68455",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions, size: 18),
                  label: const Text("Directions"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildTripDetail(
                Icons.location_on, "From: Alexandria, Moharam Bek"),
            _buildTripDetail(Icons.location_on, "To: Cairo, Giza"),
            _buildTripDetail(
                Icons.confirmation_number, "Ticket Price: 180.0 EGP"),
            _buildTripDetail(Icons.calendar_today, "Thursday, February 12"),
            _buildTripDetail(Icons.access_time, "12:05 AM"),
          ],
        ),
      ),
    );
  }

  Widget _buildTripDetail(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: orangeColor, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
