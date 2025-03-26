import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Points'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLevelCard(
                'Level 1', '10% Discount', 30, 50, Colors.orange, true),
            _buildLevelCard(
                'Level 2', '25% Discount', 0, 50, Colors.grey, false),
            _buildLevelCard(
                'Level 3', '50% Discount', 0, 50, Colors.grey, false),
            _buildLevelCard(
                'Level 4', '50 EGP Discount', 0, 50, Colors.grey, false),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(String title, String discount, int points,
      int totalPoints, Color color, bool isUnlocked) {
    return Card(
      color: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.orange : Colors.black87,
                  ),
                ),
                Icon(
                  Icons.arrow_upward,
                  color: isUnlocked ? Colors.orange : Colors.black54,
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              discount,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: points / totalPoints,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                        isUnlocked ? Colors.orange : Colors.black54),
                  ),
                ),
                const SizedBox(width: 8),
                Text('$points/$totalPoints points'),
              ],
            ),
            if (!isUnlocked)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(
                  Icons.lock,
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
