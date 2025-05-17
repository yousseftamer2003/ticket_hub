import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/controller/booking_controller.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripDetailsContent(),
            Divider(height: 32, thickness: 1),
            PoliciesContent(),
          ],
        ),
      ),
    );
  }
}

class TripDetailsContent extends StatelessWidget {
  const TripDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
        final trip = bookingProvider.selectedTrip;

        // If trip or its bus or amenities are null, display a placeholder
        if (trip == null || trip.bus == null || trip.bus!.aminities.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Trip details not available"),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Amenities On Board:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: trip.bus!.aminities.map((amenity) {
                  return _buildAmenityItem(amenity.iconLink, amenity.name);
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmenityItem(String iconLink, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconLink.startsWith('http') || iconLink.startsWith('https')
            ? Image.network(
                iconLink,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    'assets/images/ac.svg',
                    width: 24,
                    height: 24,
                  );
                },
              )
            : SvgPicture.asset(
                'assets/images/ac.svg',
                width: 24,
                height: 24,
              ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class PoliciesContent extends StatelessWidget {
  const PoliciesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingController>(
      builder: (context, bookingProvider, _) {
        final trip = bookingProvider.selectedTrip;

        if (trip == null) {
          return _buildDefaultPolicies();
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPolicySection(
                title: "Cancellation Policy",
                content:
                    "Free cancellation up to ${trip.cancelationHours} hours before departure. "
                    "Cancellation fee: ${trip.cancelationPayAmount} (${trip.cancelationPayValue})",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDefaultPolicies() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicySection(
            title: "Cancellation Policy",
            content: "Free cancellation up to 24 hours before departure.",
          ),
          const SizedBox(height: 16),
          _buildPolicySection(
            title: "Changes Policy",
            content: "Modifications are not allowed after ticket issuance.",
          ),
          const SizedBox(height: 16),
          _buildPolicySection(
            title: "Important Note",
            content:
                "All passengers must pay an ecological zone tax of 20 MEX to enter the island.",
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
