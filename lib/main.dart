import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/weather_service.dart';

/// The entry point of the application.
void main() {
  runApp(MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Create an instance of WeatherService to be provided to descendants
      create: (context) => WeatherService(),
      child: MaterialApp(
        // The title of the app, used by the device to identify the app
        title: 'Weather App',
        // Define the default theme for the app
        theme: ThemeData(
          // Set the primary color palette
          primarySwatch: Colors.blue,
          // Adjust the visual density based on the platform
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Set the home screen of the app
        home: HomeScreen(),
      ),
    );
  }
}