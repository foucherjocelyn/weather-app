class Location {
  final String city;
  final String region;
  final String country;
  final double latitude;
  final double longitude;

  Location({
    required this.city,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['name'] as String,
      region: (json['admin1'] as String?) ?? (json['admin2'] as String?) ?? '',
      country: json['country'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
