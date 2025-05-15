import 'package:advanced_weather_app/models/current_weather_model.dart';
import 'package:advanced_weather_app/utils/weather_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Location
                Column(
                  children: [
                    Text(
                      weatherModel.location.city!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${weatherModel.location.region}, ${weatherModel.location.country}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                // Temperature
                Text(
                  '${weatherModel.currentTemperature}°C',
                  style: TextStyle(fontSize: 48.0, color: Colors.orange),
                ),

                const SizedBox(height: 40),
                // Weather description
                Column(
                  children: [
                    Text(
                      weatherModel.currentWeatherDescription,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16.0),
                    Icon(
                      getWeatherIcon(weatherModel.currentWeatherDescription),
                      size: 64.0,
                      color: const Color(0xFF7E57C2),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Wind speed
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.air, size: 28.0, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    Text(
                      '${weatherModel.currentWindSpeed} km/h',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
