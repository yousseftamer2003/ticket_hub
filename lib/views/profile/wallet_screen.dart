import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/wallet/wallet_provider.dart';
import 'package:ticket_hub/model/wallet/wallet_model.dart';
import 'package:ticket_hub/model/wallet/wallet_history_model.dart';
import 'package:ticket_hub/views/profile/wallet_recharge_screen.dart';

import '../../generated/l10n.dart' show S;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletProvider>(context, listen: false).fetchWallets(context);
      Provider.of<WalletProvider>(context, listen: false)
          .fetchWalletHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        S.of(context).wallet,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<WalletProvider>(
          builder: (context, walletProvider, child) {
            if (walletProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (walletProvider.errorMessage.isNotEmpty) {
              return Center(child: Text(walletProvider.errorMessage));
            }

            List<Wallet> wallets = walletProvider.wallets;
            List<TransactionHistory> transactions =
                walletProvider.walletHistory;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).user_balance,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      ...wallets.map((wallet) => CurrencyTile(
                            currency: wallet.currency.name,
                            amount: '${wallet.currency.symbol}${wallet.amount}',
                            description: wallet.currency.name,
                            walletId: wallet.id,
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).transaction_history,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_isExpanded)
                        transactions.isNotEmpty
                            ? Column(
                                children: transactions
                                    .map((transaction) => TransactionTile(
                                          amount:
                                              '${transaction.currency.symbol}${transaction.amount}',
                                          date: transaction.createdAt
                                              .toLocal()
                                              .toString()
                                              .split(' ')[0],
                                          description:
                                              transaction.paymentMethod.name,
                                          isPositive: transaction.amount > 0,
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: Text(
                                  S.of(context).no_transactions,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CurrencyTile extends StatelessWidget {
  final String currency;
  final String amount;
  final String description;
  final int walletId; // Add walletId parameter

  const CurrencyTile({
    super.key,
    required this.currency,
    required this.amount,
    required this.description,
    required this.walletId, // Initialize walletId
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(currency,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: Text('$description: $amount'),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => WalletRechargeScreen(walletid: walletId),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Recharge'),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String amount;
  final String date;
  final String description;
  final bool isPositive;

  const TransactionTile({
    super.key,
    required this.amount,
    required this.date,
    required this.description,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
        color: isPositive ? Colors.green : Colors.red,
      ),
      title: Text(description),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(
          color: isPositive ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
