import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/controller/points/points_provider.dart';

import '../../generated/l10n.dart' show S;

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  int? _selectedCurrencyId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PointsProvider>(context, listen: false).fetchPoints(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).points,
        ),
        centerTitle: true,
      ),
      body: Consumer<PointsProvider>(builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        final pointsModel = provider.pointsModel;
        if (pointsModel == null) {
          return Center(child: Text(S.of(context).noDataAvailable));
        }

        final userPoints = pointsModel.userData.points;
        final redeemList = pointsModel.redeemPoints;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: orangeColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      S.of(context).currentPoints,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "$userPoints",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).conversionOptions,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: redeemList.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).noConversionOptions,
                        ),
                      )
                    : ListView.builder(
                        itemCount: redeemList.length,
                        itemBuilder: (context, index) {
                          final redeem = redeemList[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${redeem.points} ${S.of(context).pointsConversion} ${redeem.currencies} ${redeem.currency.symbol}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${S.of(context).currency}: ${redeem.currency.name}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (redeemList.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).selectCurrency,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: _selectedCurrencyId,
                  items: redeemList
                      .map((redeem) => DropdownMenuItem<int>(
                            value: redeem.currency.id,
                            child: Text(redeem.currency.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCurrencyId = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    hintText: S.of(context).selectCurrency,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _selectedCurrencyId == null || userPoints == 0
                      ? null
                      : () async {
                          final success = await provider.convertPoints(
                            context,
                            _selectedCurrencyId!,
                            userPoints,
                          );

                          if (success && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Points converted successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    S.of(context).redeemMyPoints,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ],
          ),
        );
      }),
    );
  }
}
