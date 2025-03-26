class TransactionHistory {
  final int id;
  final int userId;
  final int currencyId;
  final int walletId;
  final String? image;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int paymentMethodId;
  final String status;
  final Currency currency;
  final PaymentMethod paymentMethod;

  TransactionHistory({
    required this.id,
    required this.userId,
    required this.currencyId,
    required this.walletId,
    required this.image,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentMethodId,
    required this.status,
    required this.currency,
    required this.paymentMethod,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      id: json['id'],
      userId: json['user_id'],
      currencyId: json['currency_id'],
      walletId: json['wallet_id'],
      image: json['image'],
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      paymentMethodId: json['payment_method_id'],
      status: json['status'],
      currency: Currency.fromJson(json['currency']),
      paymentMethod: PaymentMethod.fromJson(json['payment_method']),
    );
  }
}

class Currency {
  final int id;
  final String name;
  final String symbol;

  Currency({
    required this.id,
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
    );
  }
}

class PaymentMethod {
  final int id;
  final String name;

  PaymentMethod({
    required this.id,
    required this.name,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TransactionHistoryList {
  final List<TransactionHistory> history;

  TransactionHistoryList({required this.history});

  factory TransactionHistoryList.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryList(
      history: (json['history'] as List)
          .map((item) => TransactionHistory.fromJson(item))
          .toList(),
    );
  }
}
