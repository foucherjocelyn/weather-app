# Advanced Weather App

A comprehensive Flutter weather application that provides current weather conditions, hourly forecasts, and weekly weather predictions with location-based services.

## Features

### 🌤️ Weather Information
- **Current Weather**: Real-time temperature, weather conditions, and wind speed
- **Hourly Forecast**: 24-hour weather predictions with detailed charts
- **Weekly Forecast**: 7-day weather outlook with daily summaries
- **Weather Descriptions**: Detailed weather condition descriptions with appropriate icons

### 📍 Location Services
- **GPS Location**: Automatic current location detection
- **Location Search**: Manual location search and selection
- **Multi-location Support**: Switch between different locations easily
- **Geocoding**: Convert coordinates to readable location names

### 🎨 User Interface
- **Tab Navigation**: Three main tabs for Current, Today, and Weekly weather
- **Custom Theming**: Beautiful weather-themed UI with background images
- **Charts & Graphs**: Visual representation of weather data using FL Chart
- **Responsive Design**: Optimized for various screen sizes

## Screenshots

*Add screenshots of your app here*

## Technologies Used

### Framework & Language
- **Flutter**: Cross-platform mobile app development
- **Dart**: Programming language

### Key Dependencies
- **Provider**: State management solution
- **HTTP**: API communication for weather data
- **Geolocator**: GPS location services
- **Geocoding**: Location name resolution
- **FL Chart**: Beautiful charts and graphs for data visualization

### APIs
- **Open-Meteo API**: Free weather API for current conditions and forecasts

## Getting Started

### Prerequisites
- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Physical device or emulator for testing location services

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/foucherjocelyn/weather-app.git
   cd weather-app/mobileModule03/advanced_weather_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-specific Setup

#### Android
- Ensure location permissions are properly configured
- Test on a physical device for best location accuracy

#### iOS
- Add location usage descriptions in `Info.plist`
- Test on a physical device for location services

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   ├── current_weather_model.dart
│   ├── daily_weather_model.dart
│   ├── hourly_weather_model.dart
│   └── location_model.dart
├── services/                 # Business logic services
│   └── location_service.dart
├── utils/                    # Utility functions and themes
│   ├── app_theme.dart
│   ├── get_weather_description.dart
│   └── weather_icon_utils.dart
└── widgets/                  # UI components
    ├── bottom_bar.dart
    ├── custom_tab_bar_view.dart
    ├── top_bar.dart
    └── weather_tabs/         # Tab-specific widgets
        ├── current_weather_tab.dart
        ├── today_weather_tab.dart
        └── weekly_weather_tab.dart
```

## Key Features Implementation

### State Management
The app uses the **Provider** pattern for state management with:
- `LocationService`: Manages GPS and location data
- `CurrentWeatherModel`: Handles current weather information
- `HourlyWeatherModel`: Manages hourly forecast data
- `DailyWeatherModel`: Manages weekly weather predictions

### Weather Data Flow
1. Location service detects or receives location input
2. Weather models fetch data from Open-Meteo API
3. UI updates automatically through Provider notifications
4. Charts and widgets display formatted weather information

### Error Handling
- Location permission handling
- Network error management
- API response validation
- User-friendly error messages

## API Information

This app uses the **Open-Meteo API**, which provides:
- Free access to weather data
- No API key required
- Current weather conditions
- Hourly and daily forecasts
- Global coverage

API Endpoint: `https://api.open-meteo.com/v1/forecast`

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Future Enhancements

- [ ] Weather alerts and notifications
- [ ] Favorite locations management
- [ ] Weather maps integration
- [ ] Dark mode support
- [ ] Weather widgets for home screen
- [ ] Offline data caching
- [ ] Multiple weather data sources

## License

This project is part of a mobile development course (Module 03) and is intended for educational purposes.

## Acknowledgments

- Open-Meteo for providing free weather API
- Flutter team for the excellent framework
- Contributors to the open-source packages used

---

*Built with ❤️ using Flutter*
