import 'package:flutter/material.dart';

IconData getWeatherIcon(String description) {
  if (description.contains('Clear') || description.contains('Mainly clear')) {
    return Icons.wb_sunny;
  } else if (description.contains('Partly cloudy')) {
    return Icons.wb_cloudy;
  } else if (description.contains('Overcast')) {
    return Icons.cloud;
  } else if (description.contains('Fog')) {
    return Icons.foggy;
  } else if (description.contains('drizzle') || description.contains('Slight rain')) {
    return Icons.water_drop;
  } else if (description.contains('rain') || description.contains('shower')) {
    return Icons.water_drop;
  } else if (description.contains('snow')) {
    return Icons.ac_unit;
  } else if (description.contains('thunderstorm')) {
    return Icons.thunderstorm;
  }
  
  // Default
  return Icons.cloud;
}