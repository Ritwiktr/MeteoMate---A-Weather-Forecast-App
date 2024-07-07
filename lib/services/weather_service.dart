import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

/// Service class for fetching weather data and managing weather-related state
class WeatherService extends ChangeNotifier {
  static const String API_KEY = '';
  static const String API_URL = '';

  WeatherModel? _weather;
  String? _error;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  String? get error => _error;
  bool get isLoading => _isLoading;

  /// Fetches weather data for a given city
  ///
  /// @param cityName The name of the city to fetch weather for
  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$API_URL?q=$cityName&appid=$API_KEY&units=metric'));

      if (response.statusCode == 200) {
        _weather = WeatherModel.fromJson(json.decode(response.body));
        await _saveLastSearchedCity(cityName);
      } else {
        _error = 'Failed to fetch weather data';
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Saves the last searched city name to SharedPreferences
  ///
  /// @param cityName The name of the city to save
  Future<void> _saveLastSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', cityName);
  }

  /// Retrieves the last searched city name from SharedPreferences
  ///
  /// @return The last searched city name, or null if not found
  Future<String?> getLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastSearchedCity');
  }
}