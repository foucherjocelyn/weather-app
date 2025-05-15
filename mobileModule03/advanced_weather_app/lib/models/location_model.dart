
//TODO: make non-nullable
class Location {
  final String? city;
  final String? region;
  final String? country;
  final double latitude;  // Make non-nullable
  final double longitude; // Make non-nullable

  Location({
    this.city,
    this.region,
    this.country,
    required this.latitude,  // Required parameter
    required this.longitude, // Required parameter
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['name'] as String?,
      region: json['admin1'] as String?,
      country: json['country'] as String?,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
