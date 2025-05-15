import 'package:advanced_weather_app/widgets/weather_tabs/current_weather_tab.dart';
import 'package:advanced_weather_app/widgets/weather_tabs/today_weather_tab.dart';
import 'package:advanced_weather_app/widgets/weather_tabs/weekly_weather_tab.dart';
import 'package:flutter/material.dart';

class CustomTabBarView extends StatelessWidget {
  final String placeholderTextCurrently;
  final String placeholderTextToday;
  final String placeholderTextWeekly;

  const CustomTabBarView({
    super.key,
    required this.placeholderTextCurrently,
    required this.placeholderTextToday,
    required this.placeholderTextWeekly,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        CurrentWeatherTab(placeholderText: placeholderTextCurrently),
        TodayWeatherTab(placeholderText: placeholderTextToday),
        WeeklyWeatherTab(placeholderText: placeholderTextWeekly),
      ],
    );
  }
}