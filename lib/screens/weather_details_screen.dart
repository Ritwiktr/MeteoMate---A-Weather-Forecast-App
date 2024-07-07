import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_service.dart';
import '../widgets/weather_widgets.dart';

/// A screen that displays weather details based on the current state of the WeatherService.
class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // Use Consumer to listen to changes in the WeatherService
        return Consumer<WeatherService>(
          builder: (context, weatherService, child) {
            // Check the current state of the WeatherService and display appropriate widget
            if (weatherService.isLoading) {
              // Show loading screen while fetching data
              return WeatherWidgets.buildLoadingScreen();
            } else if (weatherService.error != null) {
              // Show error screen if there's an error, with option to retry
              return WeatherWidgets.buildErrorScreen(weatherService.error!, () {
                weatherService.fetchWeather('');
              });
            } else if (weatherService.weather != null) {
              // Show weather data if it's available
              return WeatherWidgets.buildWeatherScreen(context, weatherService.weather!);
            } else {
              // Show a screen prompting to fetch data if no data is available
              return WeatherWidgets.buildNoDataScreen(() {
                weatherService.fetchWeather('');
              });
            }
          },
        );
      },
    );
  }
}