import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/location_model.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationService extends ChangeNotifier {
  Location? _currentLocation;
  String? _error;

  Location? get currentLocation => _currentLocation;
  String? get error => _error;

  Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<void> fetchCurrentLocation() async {
    try {
      final position = await getCurrentPosition();
      if (position != null) {
        // Default values in case geocoding fails
        String city = "Current Location";
        String region = "";
        String country = "";
        
        try {
          final placemarks = await geo.placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
          
          if (placemarks.isNotEmpty) {
            final placemark = placemarks.first;
            city = placemark.locality ?? placemark.subAdministrativeArea ?? "Current Location";
            region = placemark.administrativeArea ?? "";
            country = placemark.country ?? "";
            
            print('Reverse geocoded: $city, $region, $country');
          }
        } catch (e) {
          _error = e.toString();
        }
        
        // Create a Location object with the geocoded information
        final location = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          city: city,
          region: region,
          country: country,
        );
        
        updateCurrentLocation(location);
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      print('Error getting location: $e');
    }
  }

  Future<List<Location>> searchCities(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await http.get(
        Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$query'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body)['results'] ?? [];
        return results.map((json) => Location.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      // _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  void updateCurrentLocation(Location location) {
    _currentLocation = location;
    _error = null;
    notifyListeners();
  }

  void setError(String errorMessage) {
    _error = errorMessage;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}