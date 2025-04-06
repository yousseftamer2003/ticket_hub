class MainData {
  final List<Country> countries;
  final List<City> cities;
  final List<Brand> brands;

  MainData({
    required this.countries,
    required this.cities,
    required this.brands,
  });

  factory MainData.fromJson(Map<String, dynamic> json) {
    return MainData(
      countries:
          (json['countries'] as List).map((e) => Country.fromJson(e)).toList(),
      cities: (json['cities'] as List).map((e) => City.fromJson(e)).toList(),
      brands: (json['brands'] as List).map((e) => Brand.fromJson(e)).toList(),
    );
  }
}

class Country {
  final int id;
  final String name;

  Country({required this.id, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class City {
  final int id;
  final int countryId;
  final String name;

  City({
    required this.id,
    required this.countryId,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      countryId: json['country_id'],
      name: json['name'],
    );
  }
}

class Brand {
  final int id;
  final int categoryId;
  final String name;
  final int status;
  final String image;
  final String imageLink;
  final CarCategory carCategory;

  Brand({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.status,
    required this.image,
    required this.imageLink,
    required this.carCategory,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      status: json['status'],
      image: json['image'],
      imageLink: json['image_link'],
      carCategory: CarCategory.fromJson(json['carcategory']),
    );
  }
}

class CarCategory {
  final int id;
  final String name;
  final String? imageLink;

  CarCategory({
    required this.id,
    required this.name,
    this.imageLink,
  });

  factory CarCategory.fromJson(Map<String, dynamic> json) {
    return CarCategory(
      id: json['id'],
      name: json['name'],
      imageLink: json['image_link'],
    );
  }
}
