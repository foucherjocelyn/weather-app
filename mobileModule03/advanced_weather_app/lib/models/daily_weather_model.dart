import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medium_weather_app/models/location_model.dart';
import 'package:medium_weather_app/utils/get_weather_description.dart';

Future<http.Response> fetchDailyWeather(
  double latitude,
  double longitude,
) async {
  final response = await http.get(
    Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&daily=weather_code,temperature_2m_max,temperature_2m_min',
    ),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load daily weather');
  }
}

class DailyWeatherModel extends ChangeNotifier {
  Location location;
  List<DailyWeather> dailyWeatherList;
  String? error;

  DailyWeatherModel({required this.location, this.error})
    : dailyWeatherList = [] {
    if (error == null) {
      _initializeWeather();
    } else {
      notifyListeners();
    }
  }

  Future<void> _initializeWeather() async {
    try {
      final response = await fetchDailyWeather(
        location.latitude,
        location.longitude,
      );
      final weatherData = json.decode(response.body);
      final daily = weatherData['daily'];

      final List<String> dates = List<String>.from(daily['time']);
      final List<double> maxTemps = List<double>.from(
        daily['temperature_2m_max'].map((t) => t.toDouble()),
      );
      final List<double> minTemps = List<double>.from(
        daily['temperature_2m_min'].map((t) => t.toDouble()),
      );
      final List<int> weatherCodes = List<int>.from(daily['weather_code']);

      dailyWeatherList = List.generate(
        dates.length,
        (i) => DailyWeather(
          date: DateTime.parse(dates[i]),
          temperatureMax: maxTemps[i],
          temperatureMin: minTemps[i],
          weatherDescription: getWeatherDescription(weatherCodes[i]),
        ),
      );
      error = null;

      updateDailyWeather();
    } catch (e) {
      error = 'Error loading weather data: $e';
      notifyListeners();
    }
  }

  void updateDailyWeather() {
    print('Daily weather updated');
    notifyListeners();
  }
}

class DailyWeather {
  final DateTime date;
  final double temperatureMin;
  final double temperatureMax;
  final String weatherDescription;

  DailyWeather({
    required this.date,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.weatherDescription,
  });
}
