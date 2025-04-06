class PointsModel {
  final UserData userData;
  final List<RedeemPoints> redeemPoints;

  PointsModel({required this.userData, required this.redeemPoints});

  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      userData: UserData.fromJson(json['user_data'] ?? {}),
      redeemPoints: (json['redeem_points'] as List? ?? [])
          .map((e) => RedeemPoints.fromJson(e))
          .toList(),
    );
  }
}

class UserData {
  final int id;
  final int countryId;
  final int cityId;
  final int zoneId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String gender;
  final int nationalityId;
  final String code;
  final String image;
  final int points;
  final String imageLink;

  UserData({
    required this.id,
    required this.countryId,
    required this.cityId,
    required this.zoneId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.nationalityId,
    required this.code,
    required this.image,
    required this.points,
    required this.imageLink,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      countryId: json['country_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      zoneId: json['zone_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      gender: json['gender'] ?? '',
      nationalityId: json['nationality_id'] ?? 0,
      code: json['code'] ?? '',
      image: json['image'] ?? '',
      points: json['points'] ?? 0,
      imageLink: json['image_link'] ?? '',
    );
  }
}

class RedeemPoints {
  final int id;
  final int currencyId;
  final int points;
  final int currencies;
  final String createdAt;
  final String updatedAt;
  final Currency currency;

  RedeemPoints({
    required this.id,
    required this.currencyId,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
    required this.currencies,
  });

  factory RedeemPoints.fromJson(Map<String, dynamic> json) {
    return RedeemPoints(
      id: json['id'] ?? 0,
      currencyId: json['currency_id'] ?? 0,
      points: json['points'] ?? 0,
      currencies: json['currencies'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      currency: Currency.fromJson(json['currency'] ?? {}),
    );
  }
}

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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}
