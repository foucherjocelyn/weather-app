import 'package:flutter/material.dart';
import 'package:advanced_weather_app/models/current_weather_model.dart';
import 'package:advanced_weather_app/models/daily_weather_model.dart';
import 'package:advanced_weather_app/models/hourly_weather_model.dart';
import 'package:provider/provider.dart';

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

class CurrentWeatherTab extends StatelessWidget {
  final String placeholderText;

  const CurrentWeatherTab({super.key, required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentWeatherModel>(
      builder: (context, weatherModel, child) {
        if (weatherModel.error != null) {
          return Center(
            child: Text(
              weatherModel.error!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return TabContent(
          content: '''
${weatherModel.location.city}
${weatherModel.location.region}
${weatherModel.location.country}
Temperature: ${weatherModel.currentTemperature}°C
Weather: ${weatherModel.currentWeatherDescription}
Wind Speed: ${weatherModel.currentWindSpeed} m/s
''',
        );
      },
    );
  }
}

class TodayWeatherTab extends StatelessWidget {
  final String placeholderText;

  const TodayWeatherTab({super.key, required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return Consumer<HourlyWeatherModel>(
      builder: (context, weatherModel, child) {
        if (weatherModel.error != null) {
          return Center(
            child: Text(
              weatherModel.error!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              Text('${weatherModel.location.city}'),
              Text('${weatherModel.location.region}'),
              Text('${weatherModel.location.country}'),
              const SizedBox(height: 16.0),
              ...weatherModel.hourlyWeatherList.map((hourly) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        '${hourly.time.hour}:${hourly.time.minute}',
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${hourly.temperature}°C',
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${hourly.weatherDescription}',
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${hourly.windSpeed} m/s',
                        softWrap: true,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class WeeklyWeatherTab extends StatelessWidget {
  final String placeholderText;

  const WeeklyWeatherTab({super.key, required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyWeatherModel>(
      builder: (context, weatherModel, child) {
        if (weatherModel.error != null) {
          return Center(
            child: Text(
              weatherModel.error!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              Text('${weatherModel.location.city}'),
              Text('${weatherModel.location.region}'),
              Text('${weatherModel.location.country}'),
              const SizedBox(height: 16.0),
              ...weatherModel.dailyWeatherList.map((daily) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        '${daily.date.day}/${daily.date.month}/${daily.date.year}',
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${daily.temperatureMin}°C / ${daily.temperatureMax}°C',
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${daily.weatherDescription}',
                        softWrap: true,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class TabContent extends StatelessWidget {
  final String content;

  const TabContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [Text(content, style: const TextStyle(fontSize: 24.0))],
        ),
      ),
    );
  }
}
