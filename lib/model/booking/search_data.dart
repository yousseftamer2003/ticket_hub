class SearchData {
  int? departureFromId;
  int? arrivalToId;
  String? departureStation;
  String? arrivalStation;
  String? departureDate;
  String? returnDate;
  int? travelers;
  String? type;
  List<Traveler>? travelersList;

  SearchData(
      {this.departureFromId,
      this.arrivalStation,
      this.departureStation,
      this.arrivalToId,
      this.departureDate,
      this.returnDate,
      this.travelers = 1,
      this.travelersList,
      this.type = 'one_way'});
}

class Traveler {
  String? name;
  String? age;

  Traveler({this.age, this.name});

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
}
