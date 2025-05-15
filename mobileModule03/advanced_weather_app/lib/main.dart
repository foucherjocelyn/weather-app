import 'package:flutter/material.dart';
import 'package:medium_weather_app/models/current_weather_model.dart';
import 'package:medium_weather_app/models/daily_weather_model.dart';
import 'package:medium_weather_app/models/hourly_weather_model.dart';
import 'package:medium_weather_app/services/location_service.dart';
import 'package:medium_weather_app/widgets/custom_tab_bar_view.dart';
import 'package:medium_weather_app/widgets/bottom_bar.dart';
import 'package:medium_weather_app/widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'models/location_model.dart';

void main() {
  final locationService = LocationService();
  Location initialLocation = Location(
    city: 'Paris',
    region: 'Île-de-France',
    country: 'France',
    latitude: 48.8566,
    longitude: 2.3522,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: locationService,
        ),
        ChangeNotifierProxyProvider<LocationService, CurrentWeatherModel>(
          create: (context) => CurrentWeatherModel(
            location: initialLocation,
          ),
          update: (context, locationService, previousModel) {
            // Pass location service error to the weather model
            return CurrentWeatherModel(
              location: locationService.currentLocation ?? initialLocation,
              error: locationService.error,
            );
          },
        ),
        ChangeNotifierProxyProvider<LocationService, HourlyWeatherModel>(
          create: (context) => HourlyWeatherModel(
            location: initialLocation,
          ),
          update: (context, locationService, previousModel) {
            // Pass location service error to the weather model
            return HourlyWeatherModel(
              location: locationService.currentLocation ?? initialLocation,
              error: locationService.error,
            );
          },
        ),
        ChangeNotifierProxyProvider<LocationService, DailyWeatherModel>(
          create: (context) => DailyWeatherModel(
            location: initialLocation
          ),
          update: (context, locationService, previousModel) {
            // Pass location service error to the weather model
            return DailyWeatherModel(
              location: locationService.currentLocation ?? initialLocation,
              error: locationService.error,
            );
          },
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController searchText = TextEditingController();
  String placeholderTextCurrently = '';
  String placeholderTextToday = '';
  String placeholderTextWeekly = '';

  @override
  void initState() {
    super.initState();
    // Call the method in LocationService instead
    context.read<LocationService>().fetchCurrentLocation();
  }

  void changeLocation(Location location) {
    final locationService = context.read<LocationService>();
    locationService.updateCurrentLocation(location);
    print('Location changed to: ${location.city}, ${location.region}, ${location.country}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TopBar(
            searchText: searchText,
            // Call the method in LocationService
            onLocationPressed: () => context.read<LocationService>().fetchCurrentLocation(),
            onSearchPressed: (Location currentLocation) => changeLocation(currentLocation),
          ),
          bottomNavigationBar: const BottomBar(),
          body: CustomTabBarView(
            placeholderTextCurrently: placeholderTextCurrently,
            placeholderTextToday: placeholderTextToday,
            placeholderTextWeekly: placeholderTextWeekly,
          ),
        ),
      ),
    );
  }
}
