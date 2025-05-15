import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medium_weather_app/models/location_model.dart';
import 'package:medium_weather_app/utils/get_weather_description.dart';

Future<http.Response> fetchCurrentWeather(
  double latitude,
  double longitude,
) async {
  final response = await http.get(
    Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,wind_speed_10m,weather_code',
    ),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load current weather');
  }
}

class CurrentWeatherModel extends ChangeNotifier {
  Location location;
  double currentTemperature;
  String currentWeatherDescription;
  double currentWindSpeed;
  String? error;

  CurrentWeatherModel({
    required this.location,
    this.error,
  }) : currentTemperature = 0.0,
       currentWeatherDescription = error != null ? 'Error' : 'Loading...',
       currentWindSpeed = 0.0 {
    if (error == null) {
      _initializeWeather();
    } else {
      notifyListeners();
    }
  }

  Future<void> _initializeWeather() async {
    try {
      final response = await fetchCurrentWeather(location.latitude, location.longitude);
      final weatherData = json.decode(response.body);
      final current = weatherData['current'];
      
      currentTemperature = current['temperature_2m']?.toDouble() ?? 0.0;
      currentWindSpeed = current['wind_speed_10m']?.toDouble() ?? 0.0;
      currentWeatherDescription = getWeatherDescription(current['weather_code'] ?? 0);
      error = null;
      
      updateWeather();
    } catch (e) {
      error = 'Error loading weather data: $e';
      notifyListeners();
    }
  }

  void updateWeather() {
    print('Weather updated');
    notifyListeners();
  }
}
