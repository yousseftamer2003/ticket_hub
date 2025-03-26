class SearchData {
  int? departureFromId;
  int? arrivalToId;
  String? departureStation;
  String? arrivalStation;
  String? departureDate;
  String? returnDate;
  int? travelers;
  String? type;

  SearchData(
      {this.departureFromId,
      this.arrivalStation,
      this.departureStation,
      this.arrivalToId,
      this.departureDate = 'Select Date',
      this.returnDate,
      this.travelers  = 1,
      this.type = 'one_way'});
}
