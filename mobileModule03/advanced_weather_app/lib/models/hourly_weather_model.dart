import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medium_weather_app/models/location_model.dart';
import 'package:medium_weather_app/utils/get_weather_description.dart';
import 'dart:convert';

Future<http.Response> fetchHourlyWeather(
  double latitude,
  double longitude,
) async {
  final response = await http.get(
    Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&hourly=temperature_2m,weather_code,wind_speed_10m&forecast_days=1',
    ),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load hourly weather');
  }
}

class HourlyWeatherModel extends ChangeNotifier {
  Location location;
  List<HourlyWeather> hourlyWeatherList;
  String? error;

  HourlyWeatherModel({
    required this.location,
    this.error,
  }) : hourlyWeatherList = [] {
    if (error == null) {
      _initializeWeather();
    } else {
      notifyListeners();
    }
  }

  Future<void> _initializeWeather() async {
    try {
      final response = await fetchHourlyWeather(location.latitude, location.longitude);
      final weatherData = json.decode(response.body);
      final hourly = weatherData['hourly'];
      
      final List<String> times = List<String>.from(hourly['time']);
      final List<double> temperatures = List<double>.from(
          hourly['temperature_2m'].map((t) => t.toDouble()));
      final List<int> weatherCodes = List<int>.from(hourly['weather_code']);
      final List<double> windSpeeds = List<double>.from(
          hourly['wind_speed_10m'].map((w) => w.toDouble()));

      hourlyWeatherList = List.generate(
        times.length,
        (i) => HourlyWeather(
          time: DateTime.parse(times[i]),
          temperature: temperatures[i],
          weatherDescription: getWeatherDescription(weatherCodes[i]),
          windSpeed: windSpeeds[i],
        ),
      );
      error = null;

      updateHourlyWeather();
    } catch (e) {
      error = 'Error loading weather data: $e';
      notifyListeners();
    }
  }

  void updateHourlyWeather() {
    print('Hourly weather updated');
    notifyListeners();
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String weatherDescription;
  final double windSpeed;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherDescription,
    required this.windSpeed,
  });
}