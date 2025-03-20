class SearchResult {
  final List<AllTrips> allTrips;

  SearchResult({required this.allTrips});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      allTrips: List<AllTrips>.from(json['all_trips'].map((x) => AllTrips.fromJson(x))),
    );
  }
}

class AllTrips {
  final int id;
  final int busId;
  final int pickupStationId;
  final int dropStationId;
  final String pickupStationName;
  final String dropStationName;
  final String? tripType;
  final String tripName;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final int availableSeats;
  final int price;
  final String busNumber;
  final String busImage;

  AllTrips(
      {required this.id,
      required this.busId,
      required this.pickupStationId,
      required this.dropStationId,
      required this.pickupStationName,
      required this.dropStationName,
      required this.tripType,
      required this.tripName,
      required this.departureTime,
      required this.arrivalTime,
      required this.date,
      required this.availableSeats,
      required this.price,
      required this.busNumber,
      required this.busImage});

  factory AllTrips.fromJson(Map<String, dynamic> json) {
    return AllTrips(
      id: json['id'],
      busId: json['bus_id'],
      pickupStationId: json['pickup_station_id'],
      dropStationId: json['drop_station_id'],
      pickupStationName: json['pickup_station_name'],
      dropStationName: json['dropoff_station_id'],
      tripType: json['trip_type'] ?? 'N/A',
      tripName: json['trip_name'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      date: json['date'],
      availableSeats: json['available_seats'],
      price: json['price'],
      busNumber: json['bus']['bus_number'],
      busImage: json['bus']['image_link'],
    );
  }
}
