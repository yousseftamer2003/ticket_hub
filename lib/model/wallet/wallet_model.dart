import 'dart:convert';

class WalletsResponse {
  final List<Wallet> wallets;

  WalletsResponse({required this.wallets});

  factory WalletsResponse.fromJson(String str) => 
      WalletsResponse.fromMap(json.decode(str));

  factory WalletsResponse.fromMap(Map<String, dynamic> json) => WalletsResponse(
        wallets: List<Wallet>.from(json["wallets"].map((x) => Wallet.fromMap(x))),
      );
}

class Wallet {
  final int id;
  final int userId;
  final int currencyId;
  final double amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Currency currency;

  Wallet({
    required this.id,
    required this.userId,
    required this.currencyId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
  });

  factory Wallet.fromMap(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        userId: json["user_id"],
        currencyId: json["currency_id"],
        amount: (json["amount"] as num).toDouble(),
        createdAt:
            json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt:
            json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        currency: Currency.fromMap(json["currency"]),
      );
}

class Currency {
  final int id;
  final String name;
  final String symbol;

  Currency({required this.id, required this.name, required this.symbol});

  factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
      );
}
