class Currency {
  final int id;
  final String name;
  final String symbol;
  final int status;

  Currency({
    required this.id,
    required this.name,
    required this.symbol,
    required this.status,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'status': status,
    };
  }
}

class PaymentMethod {
  final int id;
  final String name;
  final String image;
  final String status;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
    };
  }
}

class PaymentDataModel {
  final List<Currency> currencies;
  final List<PaymentMethod> paymentMethods;

  PaymentDataModel({required this.currencies, required this.paymentMethods});

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentDataModel(
      currencies: (json['currencies'] as List)
          .map((e) => Currency.fromJson(e))
          .toList(),
      paymentMethods: (json['payment_methods'] as List)
          .map((e) => PaymentMethod.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencies': currencies.map((e) => e.toJson()).toList(),
      'payment_methods': paymentMethods.map((e) => e.toJson()).toList(),
    };
  }
}
