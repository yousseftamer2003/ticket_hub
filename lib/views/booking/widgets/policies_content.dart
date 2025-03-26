import 'package:flutter/material.dart';

class PoliciesContent extends StatelessWidget {
  const PoliciesContent({super.key});

  @override
  Widget build(BuildContext context) {
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
            content: "All passengers must pay an ecological zone tax of 20 MEX to enter the island.",
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
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
