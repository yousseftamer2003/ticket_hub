class City {
  final String name;
  final int id;

  City({required this.name, required this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(name: json['name'], id: json['id']);
  }
}

class Cities{
  final List<dynamic> cities;

  Cities({required this.cities});

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(cities: json['cities']);
  }
}

class PaymentMethod {
  final String name;
  final int id;
  final String imageLink;

  PaymentMethod({required this.name, required this.id, required this.imageLink});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(name: json['name'], id: json['id'], imageLink: json['image_link']);
  }
}

class PaymentMethods {
  final List<dynamic> paymentMethods;

  PaymentMethods({required this.paymentMethods});

  factory PaymentMethods.fromJson(Map<String, dynamic> json) {
    return PaymentMethods(paymentMethods: json['payment_methods']);
  }
}