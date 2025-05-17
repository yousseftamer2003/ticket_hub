class TripResponse {
  final List<Trip> allTrips;
  final List<Trip> busTrips;
  final List<Trip> hiaceTrips;
  final List<Trip> trainTrips;

  TripResponse({
    required this.allTrips,
    required this.busTrips,
    required this.hiaceTrips,
    required this.trainTrips,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) {
    return TripResponse(
      allTrips:
          (json['all_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
      busTrips:
          (json['bus_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
      hiaceTrips:
          (json['hiace_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
      trainTrips:
          (json['train_trips'] as List).map((e) => Trip.fromJson(e)).toList(),
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
  final String cancellationPolicy;
  final String cancelationPayAmount;
  final int cancelationPayValue;
  final int cancelationHours;
  final String maxBookDate;
  final double serviceFees;
  final Bus? bus;
  final Currency? currency;
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
    required this.cancellationPolicy,
    required this.cancelationPayAmount,
    required this.cancelationPayValue,
    required this.cancelationHours,
    required this.maxBookDate,
    required this.serviceFees,
    this.bus,
    this.currency,
    required this.pickupStation,
    required this.dropoffStation,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? 0,
      busId: json['bus_id'] ?? 0,
      pickupStationId: json['pickup_station_id'] ?? 0,
      dropoffStationId: json['dropoff_station_id'] ?? 0,
      tripType: json['trip_type'] ?? '',
      tripName: json['trip_name'] ?? '',
      departureTime: json['deputre_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      date: json['date'] ?? '',
      availableSeats: json['avalible_seats'] ?? 0,
      price: json['price'] ?? 0,
      cancellationPolicy: json['cancellation_policy'] ?? '',
      cancelationPayAmount: json['cancelation_pay_amount'] ?? '',
      cancelationPayValue: json['cancelation_pay_value'] ?? 0,
      cancelationHours: json['cancelation_hours'] ?? 0,
      maxBookDate: json['max_book_date'] ?? '',
      serviceFees: json['service_fees'] ?? 0,
      bus: json['bus'] != null ? Bus.fromJson(json['bus']) : null,
      currency:
          json['currency'] != null ? Currency.fromJson(json['currency']) : null,
      pickupStation: Station.fromJson(json['pickup_station']),
      dropoffStation: Station.fromJson(json['dropoff_station']),
    );
  }
}

class Bus {
  final int id;
  final int capacity;
  final Map<String, dynamic> availableSeats;
  final String busNumber;
  final String? busImage;
  final String imageLink;
  final List<Aminety> aminities;

  Bus({
    required this.id,
    required this.busNumber,
    required this.capacity,
    required this.availableSeats,
    this.busImage,
    required this.imageLink,
    required this.aminities,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'] ?? 0,
      busNumber: json['bus_number'] ?? 'N/A',
      busImage: json['bus_image'],
      imageLink: json['image_link'] ?? '',
      capacity: json['capacity'] ?? 0,
      availableSeats: json['new_areas'] ?? {},
      aminities:
          (json['aminity'] as List).map((e) => Aminety.fromJson(e)).toList(),
    );
  }
}

class Currency {
  final int id;
  final String name;
  final String symbol;

  Currency({
    required this.id,
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'N/A',
      symbol: json['symbol'] ?? 'N/A',
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
