import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/points/points_provider.dart';
import 'package:ticket_hub/model/points/points_model.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  PointsScreenState createState() => PointsScreenState();
}

class PointsScreenState extends State<PointsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PointsProvider>(context, listen: false)
        .fetchPoints(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'points'),
      body: Consumer<PointsProvider>(
        builder: (context, pointsProvider, child) {
          if (pointsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (pointsProvider.errorMessage != null) {
            return Center(child: Text(pointsProvider.errorMessage!));
          }

          if (pointsProvider.pointsModel == null) {
            return const Center(child: Text('No data available.'));
          }

          final PointsModel pointsModel = pointsProvider.pointsModel!;
          final int userPoints = pointsModel.userData.points;
          final List<RedeemPoints> redeemOptions = pointsModel.redeemPoints;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'رصيد النقاط: $userPoints نقطة',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...redeemOptions.map((redeem) {
                  return _buildLevelCard(
                    context,
                    ' ${redeem.currency.name} مكافاه',
                    '${redeem.points} نقطة مقابل ${redeem.currency.symbol}',
                    userPoints,
                    redeem.points,
                    redeem.currency.id,
                    userPoints >= redeem.points ? Colors.orange : Colors.grey,
                    userPoints >= redeem.points,
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLevelCard(
      BuildContext context,
      String title,
      String discount,
      int userPoints,
      int requiredPoints,
      int currencyId,
      Color color,
      bool isUnlocked) {
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
              style: const TextStyle(
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
                    value: userPoints / requiredPoints,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(
                        isUnlocked ? Colors.orange : Colors.black54),
                  ),
                ),
                const SizedBox(width: 8),
                Text('$userPoints/$requiredPoints نقطة'),
              ],
            ),
            if (userPoints == requiredPoints)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () => _confirmConvertPoints(
                      context, currencyId, requiredPoints),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'تحويل النقاط',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _confirmConvertPoints(BuildContext context, int currencyId, int points) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد التحويل'),
          content: Text('هل تريد تحويل $points نقطة إلى العملة المحددة؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await Provider.of<PointsProvider>(context, listen: false)
                    .convertPoints(context, currencyId, points);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('تحويل'),
            ),
          ],
        );
      },
    );
  }
}
