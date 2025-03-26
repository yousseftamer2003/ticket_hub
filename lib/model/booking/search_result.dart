class TripResponse {
  final List<Trip> allTrips;
  // final List<Trip> busTrips;
  // final List<Trip> hiaceTrips;
  // final List<Trip> trainTrips;

  TripResponse({
    required this.allTrips,
    // required this.busTrips,
    // required this.hiaceTrips,
    // required this.trainTrips,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      allTrips: (json['all_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
      // busTrips: (json['bus_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
      // hiaceTrips: (json['hiace_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
      // trainTrips: (json['train_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
    );
  }
}

class Trip {
  final int id;
  final int busId;
  final int pickupStationId;
  final int dropoffStationId;
  final String tripType;
  final String tripName;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final int availableSeats;
  final int price;
  final Bus bus;
  final Station pickupStation;
  final Station dropoffStation;

  Trip({
    required this.id,
    required this.busId,
    required this.pickupStationId,
    required this.dropoffStationId,
    required this.tripType,
    required this.tripName,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.availableSeats,
    required this.price,
    required this.bus,
    required this.pickupStation,
    required this.dropoffStation,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id']?? 0,
      busId: json['bus_id'] ?? 0,
      pickupStationId: json['pickup_station_id'] ?? 0,
      dropoffStationId: json['dropoff_station_id'] ?? 0,
      tripType: json['trip_type'] ?? 'N/A',
      tripName: json['trip_name'] ?? 'N/A',
      departureTime: json['deputre_time'] ?? 'N/A',
      arrivalTime: json['arrival_time'] ??  'N/A',
      date: json['date']??  'N/A',
      availableSeats: json['avalible_seats'] ??  0,
      price: json['price'] ?? 0,
      bus: Bus.fromJson(json['bus']),
      pickupStation: Station.fromJson(json['pickup_station']),
      dropoffStation: Station.fromJson(json['dropoff_station']),
    );
  }
}

class Bus {
  final int id;
  final String busNumber;
  final String? busImage;
  final String imageLink;

  Bus({
    required this.id,
    required this.busNumber,
    this.busImage,
    required this.imageLink,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'] ?? 0,
      busNumber: json['bus_number'] ?? 'N/A',
      busImage: json['bus_image'] ?? 'N/A',
      imageLink: json['image_link'] ?? 'N/A',
    );
  }
}

class Aminety {
  final int id;
  final String name;
  final String iconLink;

  Aminety({required this.id, required this.name, required this.iconLink});

  factory Aminety.fromJson(Map<String, dynamic> json) {
    return Aminety(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'N/A',
      iconLink: json['icon_link'] ?? 'N/A',
    );
  }
}

class Station {
  final int id;
  final String name;

  Station({
    required this.id,
    required this.name,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'N/A',
    );
  }
}
