import 'package:advanced_weather_app/models/hourly_weather_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        '${hourly.windSpeed} km/h',
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
