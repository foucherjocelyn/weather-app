import 'package:advanced_weather_app/models/daily_weather_model.dart';
import 'package:advanced_weather_app/utils/weather_icon_utils.dart';
import 'package:fl_chart/fl_chart.dart';
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
                              reservedSize: 40,
                              minIncluded: false,
                              maxIncluded: false,
                              interval: 5,
                              getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()}°C',
                                style: const TextStyle(fontSize: 12),
                              );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,  
                              reservedSize: 18,
                              getTitlesWidget: (value, meta) {
                                if (value >= 0 && value < weatherModel.dailyWeatherList.length) {
                                  final dateOfDay = weatherModel.dailyWeatherList[value.toInt()].date;
                                  final day = dateOfDay.day.toString().padLeft(2, '0');
                                  final month = dateOfDay.month.toString().padLeft(2, '0');
                                  return Text(
                                    '$day/$month',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                }
                                return const Text('');
                              },
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
                              weatherModel.dailyWeatherList.length,
                              (index) {
                                final double day = index.toDouble();
                                final double tempMax =
                                    weatherModel
                                        .dailyWeatherList[index]
                                        .temperatureMax
                                        .toDouble();
                                return FlSpot(day, tempMax);
                              },
                            ),
                            isCurved: true,
                            color: Colors.redAccent,
                            barWidth: 3,
                          ),
                          LineChartBarData(
                            spots: List.generate(
                              weatherModel.dailyWeatherList.length,
                              (index) {
                                final double day = index.toDouble();
                                final double tempMin =
                                    weatherModel
                                        .dailyWeatherList[index]
                                        .temperatureMin
                                        .toDouble();
                                return FlSpot(day, tempMin);
                              },
                            ),
                            isCurved: true,
                            color: Colors.blueAccent,
                            barWidth: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Daily weather scrollable list
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 152, 0, 0.2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        weatherModel.dailyWeatherList.map<Widget>((daily) {
                          final date =
                              '${daily.date.day.toString().padLeft(2, '0')}/${daily.date.month.toString().padLeft(2, '0')}';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: DayWeatherInfo(
                              date: date,
                              weatherDescription: daily.weatherDescription,
                              temperatureMin: daily.temperatureMin.toString(),
                              temperatureMax: daily.temperatureMax.toString(),
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

class DayWeatherInfo extends StatelessWidget {
  final String date;
  final String weatherDescription;
  final String temperatureMin;
  final String temperatureMax;

  const DayWeatherInfo({
    super.key,
    this.date = '07/03',
    this.weatherDescription = 'Clear sky',
    this.temperatureMin = '16.0',
    this.temperatureMax = '25.0',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(date, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16.0),
        // Weather icon
        Icon(
          getWeatherIcon(weatherDescription),
          size: 36.0,
          color: const Color(0xFF7E57C2),
        ),
        const SizedBox(height: 8.0),
        // Temperature
        Text(
          '${temperatureMax}°C',
          style: TextStyle(fontSize: 18.0, color: Colors.redAccent),
        ),
        Text(
          '${temperatureMin}°C',
          style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),
        ),
      ],
    );
  }
}
