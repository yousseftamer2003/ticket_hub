import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/controller/trips/trips_provider.dart';
import 'package:ticket_hub/generated/l10n.dart' show S;
import 'package:ticket_hub/views/auth/login_screen.dart';

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
    Future.microtask(() {
      Provider.of<TripsProvider>(context, listen: false).fetchTripHistory(context);
});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TripsProvider>(
      builder: (context, tripsProvider, child) {
        if (tripsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tripsProvider.errorMessage.isNotEmpty) {
          if (tripsProvider.errorMessage == 'Authentication token is missing') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orangeColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Go to Login',
                      style: TextStyle(color: blackColor),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text(tripsProvider.errorMessage));
          }
        }

        final historyTrips = tripsProvider.tripsData?.history ?? [];
        final upcomingTrips = tripsProvider.tripsData?.upcoming ?? [];

        return Column(
          children: [
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              margin: const EdgeInsets.all(16),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: orangeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: [
                  Tab(text: S.of(context).upcoming),
                  Tab(text: S.of(context).previous),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTripsList(upcomingTrips, isHistory: false),
                  _buildTripsList(historyTrips, isHistory: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTripsList(List trips, {bool isHistory = false}) {
    if (trips.isEmpty) {
      return Center(
        child: Text(S.of(context).noTripsAvailable),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _buildTripCard(trips[index], isHistory: isHistory);
      },
    );
  }

  Widget _buildTripCard(tripHistory, {bool isHistory = false}) {
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
                Text(
                  tripHistory.trip.tripName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (isHistory) _buildStatusChip(tripHistory.status),
              ],
            ),
            const SizedBox(height: 8),
            _buildTripDetail(Icons.location_on,
                "${S.of(context).from}: ${tripHistory.trip.city.name}, ${tripHistory.trip.pickupStation.name}"),
            _buildTripDetail(Icons.location_on,
                "${S.of(context).to}: ${tripHistory.trip.toCity.name}, ${tripHistory.trip.dropoffStation.name}"),
            _buildTripDetail(Icons.numbers,
                "${S.of(context).number_of_travelers}:  ${tripHistory.travelers}"),
            _buildTripDetail(Icons.confirmation_number,
                "Ticket Price: ${tripHistory.total} EGP"),
            _buildTripDetail(Icons.calendar_today, tripHistory.travelDate),
            _buildTripDetail(Icons.access_time, tripHistory.trip.departureTime),
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
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case "confirmed":
        statusColor = Colors.green;
        break;
      case "cancelled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status.toUpperCase(),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: statusColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }
}
