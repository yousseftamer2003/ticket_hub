class Trip {
  final int id;
  final String tripName;
  final String departureTime;
  final String arrivalTime;
  final int pickupStationId;
  final int dropoffStationId;
  final int cityId;
  final int toCityId;
  final Station pickupStation;
  final Station dropoffStation;
  final City city;
  final City toCity;

  Trip({
    required this.id,
    required this.tripName,
    required this.departureTime,
    required this.arrivalTime,
    required this.pickupStationId,
    required this.dropoffStationId,
    required this.cityId,
    required this.toCityId,
    required this.pickupStation,
    required this.dropoffStation,
    required this.city,
    required this.toCity,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? 0,
      tripName: json['trip_name'] ?? '',
      departureTime: json['deputre_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      pickupStationId: json['pickup_station_id'] ?? 0,
      dropoffStationId: json['dropoff_station_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      toCityId: json['to_city_id'] ?? 0,
      pickupStation: Station.fromJson(json['pickup_station'] ?? {}),
      dropoffStation: Station.fromJson(json['dropoff_station'] ?? {}),
      city: City.fromJson(json['city'] ?? {}),
      toCity: City.fromJson(json['to_city'] ?? {}),
    );
  }
}

class Station {
  final int id;
  final String name;

  Station({required this.id, required this.name});

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class TripHistory {
  final int id;
  final int amount;
  final int total;
  final String status;
  final int travelers;
  final String travelDate;
  final int tripId;
  final String travelStatus;
  final Trip trip;

  TripHistory({
    required this.id,
    required this.amount,
    required this.total,
    required this.status,
    required this.travelers,
    required this.travelDate,
    required this.tripId,
    required this.travelStatus,
    required this.trip,
  });

  factory TripHistory.fromJson(Map<String, dynamic> json) {
    return TripHistory(
      id: json['id'] ?? 0,
      amount: json['amount'] ?? 0,
      total: json['total'] ?? 0,
      status: json['status'] ?? '',
      travelers: json['travelers'] ?? 0,
      travelDate: json['travel_date'] ?? '',
      tripId: json['trip_id'] ?? 0,
      travelStatus: json['travel_status'] ?? '',
      trip: Trip.fromJson(json['trip'] ?? {}),
    );
  }
}

class TripsData {
  final List<TripHistory> history;
  final List<TripHistory> upcoming;

  TripsData({required this.history, required this.upcoming});

  factory TripsData.fromJson(Map<String, dynamic> json) {
    return TripsData(
      history: (json['history'] as List? ?? [])
          .map((item) => TripHistory.fromJson(item))
          .toList(),
      upcoming: (json['upcoming'] as List? ?? [])
          .map((item) => TripHistory.fromJson(item))
          .toList(),
    );
  }
}
