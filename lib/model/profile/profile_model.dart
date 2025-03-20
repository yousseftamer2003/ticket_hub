class UserProfileModel {
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
  final String? code;
  final String? imageLink;

  UserProfileModel({
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
    this.code,
    this.imageLink,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
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
      code: json['code'],
      imageLink: json['image_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_id': countryId,
      'city_id': cityId,
      'zone_id': zoneId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'gender': gender,
      'nationality_id': nationalityId,
      'code': code,
      'image_link': imageLink,
    };
  }
}
