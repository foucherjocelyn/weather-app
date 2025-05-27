import 'package:advanced_weather_app/models/hourly_weather_model.dart';
import 'package:advanced_weather_app/utils/weather_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

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
                '${weatherModel.location.region}, ${weatherModel.location.country}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 56.0),
              // Temperature Chart
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 152, 0, 0.2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              minIncluded: false,
                              maxIncluded: false,
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  meta: meta,
                                  child: Text(
                                    '${value}°C',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                if (value >= 0 &&
                                    value <
                                        weatherModel.hourlyWeatherList.length) {
                                  final timeOfDay =
                                      weatherModel
                                          .hourlyWeatherList[value.toInt()]
                                          .time;
                                  final hour = timeOfDay.hour
                                      .toString()
                                      .padLeft(2, '0');
                                  final minute = timeOfDay.minute
                                      .toString()
                                      .padLeft(2, '0');
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      '$hour:$minute',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                              interval: 5,
                              minIncluded: false,
                              maxIncluded: false,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              weatherModel.hourlyWeatherList.length,
                              (index) {
                                final double hour = index.toDouble();
                                final temp =
                                    weatherModel
                                        .hourlyWeatherList[index]
                                        .temperature
                                        .toDouble();
                                return FlSpot(hour, temp);
                              },
                            ),
                            isCurved: true,
                            color: Colors.orangeAccent,
                            barWidth: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
              // Hourly weather scrollable list
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 152, 0, 0.2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        weatherModel.hourlyWeatherList.map<Widget>((hourly) {
                          final time =
                              '${hourly.time.hour.toString().padLeft(2, '0')}:${hourly.time.minute.toString().padLeft(2, '0')}';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: HourWeatherInfo(
                              time: time,
                              weatherDescription: hourly.weatherDescription,
                              temperature: hourly.temperature.toString(),
                              windSpeed: hourly.windSpeed.toString(),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}

class HourWeatherInfo extends StatelessWidget {
  final String time;
  final String weatherDescription;
  final String temperature;
  final String windSpeed;

  const HourWeatherInfo({
    super.key,
    this.time = '00:00',
    this.weatherDescription = 'Clear sky',
    this.temperature = '28.0',
    this.windSpeed = '13.4',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16.0),
        Icon(
          getWeatherIcon(weatherDescription),
          size: 36.0,
          color: const Color(0xFF7E57C2),
        ),
        const SizedBox(height: 8.0),
        // Temperature
        Text(
          '${temperature}°C',
          style: TextStyle(fontSize: 18.0, color: Colors.orange),
        ),
        // Wind speed
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.air, size: 16.0, color: Colors.blue),
            const SizedBox(width: 8.0),
            Text(
              '${windSpeed} km/h',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
