import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherWidgets {
  // Determines the gradient colors based on weather condition and time of day
  static List<Color> _getGradientColors(WeatherModel weather) {
    final hour = DateTime.now().hour;
    final condition = weather.condition.toLowerCase();

    if (condition.contains('rain') || condition.contains('drizzle')) {
      return [Color(0xFF4B6CB7), Color(0xFF182848)];
    } else if (condition.contains('cloud')) {
      return [Color(0xFF757F9A), Color(0xFFD7DDE8)];
    } else if (condition.contains('snow')) {
      return [Color(0xFFE0EAFC), Color(0xFFCFDEF3)];
    } else if (hour >= 5 && hour < 12) {
      return [Color(0xFFFFA751), Color(0xFFFFE259)]; // Morning
    } else if (hour >= 12 && hour < 17) {
      return [Color(0xFF2980B9), Color(0xFF6DD5FA)]; // Afternoon
    } else if (hour >= 17 && hour < 20) {
      return [Color(0xFFFF5F6D), Color(0xFFFFC371)]; // Evening
    } else {
      return [Color(0xFF2C3E50), Color(0xFF4CA1AF)]; // Night
    }
  }

  // Returns the appropriate weather icon based on the condition
  static IconData _getWeatherIcon(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains('clear')) return WeatherIcons.day_sunny;
    if (condition.contains('cloud')) return WeatherIcons.cloudy;
    if (condition.contains('rain')) return WeatherIcons.rain;
    if (condition.contains('snow')) return WeatherIcons.snow;
    if (condition.contains('thunder')) return WeatherIcons.thunderstorm;
    return WeatherIcons.day_sunny;
  }

  // Builds and returns the loading screen widget
  static Widget buildLoadingScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4CA1AF), Color(0xFF2C3E50)],
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(color: Colors.white)
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 500.ms)
              .then(delay: 500.ms)
              .scaleXY(begin: 0.8, end: 1.2, duration: 1000.ms)
              .then(delay: 500.ms)
              .scaleXY(begin: 1.2, end: 0.8, duration: 1000.ms),
        ),
      ),
    );
  }

  // Builds and returns the error screen widget
  static Widget buildErrorScreen(String error, VoidCallback onRetry) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 80)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .shake(delay: 500.ms),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onRetry,
                child: Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFFF5F6D), backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ).animate().fadeIn(duration: 500.ms).scale(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds and returns the no data screen widget
  static Widget buildNoDataScreen(VoidCallback onFetch) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF757F9A), Color(0xFFD7DDE8)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(WeatherIcons.day_sunny, size: 80, color: Colors.white)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(),
              SizedBox(height: 20),
              Text(
                'No weather data available',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onFetch,
                child: Text('Fetch Weather'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF757F9A), backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ).animate().fadeIn(duration: 500.ms).scale(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds and returns the main weather screen widget
  static Widget buildWeatherScreen(BuildContext context, WeatherModel weather) {
    final gradientColors = _getGradientColors(weather);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => Provider.of<WeatherService>(context, listen: false)
                .fetchWeather(weather.cityName),
            child: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // City name
                        Text(
                          weather.cityName,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn(duration: 500.ms).slideX(),
                        SizedBox(height: 20),
                        // Temperature, condition, and weather icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${weather.temperature.toStringAsFixed(1)}°C',
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).animate().fadeIn(duration: 500.ms).scale(),
                                Text(
                                  weather.condition,
                                  style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            BoxedIcon(
                              _getWeatherIcon(weather.condition),
                              size: 80,
                              color: Colors.white,
                            ).animate().fadeIn(duration: 800.ms).scale().then(delay: 500.ms).rotate(),
                          ],
                        ),
                        SizedBox(height: 40),
                        // Additional weather information
                        _buildInfoRow(WeatherIcons.humidity, 'Humidity', '${weather.humidity}%'),
                        _buildInfoRow(WeatherIcons.strong_wind, 'Wind Speed', '${weather.windSpeed} m/s'),
                        SizedBox(height: 350),
                        // Last updated timestamp
                        Center(
                          child: Text(
                            'Last updated: ${DateTime.now().toString().split('.')[0]}',
                            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build info rows (e.g., humidity, wind speed)
  static Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          BoxedIcon(icon, size: 30, color: Colors.white.withOpacity(0.8)),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8))),
              Text(value, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideX();
  }
}