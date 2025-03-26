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


class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Brand {
  final int id;
  final String name;

  Brand({required this.id, required this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Model {
  final int id;
  final String name;

  Model({required this.id, required this.name});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Car {
  final int id;
  final int categoryId;
  final int brandId;
  final int modelId;
  final int agentId;
  final String carNumber;
  final String carColor;
  final String carYear;
  final String status;
  final String image;
  final Category category;
  final Brand brand;
  final Model model;

  Car({
    required this.id,
    required this.categoryId,
    required this.brandId,
    required this.modelId,
    required this.agentId,
    required this.carNumber,
    required this.carColor,
    required this.carYear,
    required this.status,
    required this.image,
    required this.category,
    required this.brand,
    required this.model,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      categoryId: json['category_id'],
      brandId: json['brand_id'],
      modelId: json['model_id'],
      agentId: json['agent_id'],
      carNumber: json['car_number'],
      carColor: json['car_color'],
      carYear: json['car_year'],
      status: json['status'],
      image: json['image'],
      category: Category.fromJson(json['category']),
      brand: Brand.fromJson(json['brand']),
      model: Model.fromJson(json['model']),
    );
  }
}
