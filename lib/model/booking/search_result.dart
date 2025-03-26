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
      id: json['id'],
      busId: json['bus_id'],
      pickupStationId: json['pickup_station_id'],
      dropoffStationId: json['dropoff_station_id'],
      tripType: json['trip_type'],
      tripName: json['trip_name'],
      departureTime: json['deputre_time'],
      arrivalTime: json['arrival_time'],
      date: json['date'],
      availableSeats: json['avalible_seats'],
      price: json['price'],
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
      id: json['id'],
      busNumber: json['bus_number'],
      busImage: json['bus_image'],
      imageLink: json['image_link'],
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
      id: json['id'],
      name: json['name'],
    );
  }
}
