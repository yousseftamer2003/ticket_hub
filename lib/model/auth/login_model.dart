class UserModel {
  final String message;
  final User user;
  final String token;

  UserModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class User {
  final int id;
  final int? countryId;
  final int? cityId;
  final int? zoneId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? createdAt;
  final String? updatedAt;
  final String gender;
  final int? nationalityId;

  User({
    required this.id,
    this.countryId,
    this.cityId,
    this.zoneId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.createdAt,
    this.updatedAt,
    required this.gender,
    this.nationalityId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      zoneId: json['zone_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      gender: json['gender'],
      nationalityId: json['nationality_id'],
    );
  }
}
