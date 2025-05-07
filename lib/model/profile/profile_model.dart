class UserModel {
  final int id;
  final int? countryId;
  final int? cityId;
  final int? zoneId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String gender;
  final int? nationalityId;
  final String? code;
  final String? imageLink;

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      countryId: json['country_id']??0,
      cityId: json['city_id']??0,
      zoneId: json['zone_id']??0,
      name: json['name'] ?? 'No name',
      email: json['email'] ?? 'No email',
      phone: json['phone'] ?? 'No phone',
      role: json['role'] ?? 'No role',
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      gender: json['gender'] ?? 'No gender',
      nationalityId: json['nationality_id'] ?? 0,
      code: json['code'] ?? '',
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'gender': gender,
      'nationality_id': nationalityId,
      'code': code,
      'image_link': imageLink,
    };
  }
}
