import 'package:advanced_weather_app/models/daily_weather_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              Text(
                '${weatherModel.location.city}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '${weatherModel.location.region}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
