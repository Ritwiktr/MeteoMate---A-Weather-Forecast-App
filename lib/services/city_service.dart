import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service class for fetching city suggestions from the OpenWeatherMap API
class CityService {
  // API key for OpenWeatherMap
  static const String API_KEY = '8b6e24648a29f18bab7f32d5e1930559';

  // Base URL for the OpenWeatherMap Geocoding API
  static const String API_URL = 'https://api.openweathermap.org/geo/1.0/direct';

  /// Fetches city suggestions based on the user's input query
  ///
  /// @param query The user's input string
  /// @return A list of city suggestions in the format "City, Country"
  Future<List<String>> getCitySuggestions(String query) async {
    // Return an empty list if the query is less than 3 characters
    if (query.length < 3) return [];

    // Make an HTTP GET request to the API
    final response = await http.get(
      Uri.parse('$API_URL?q=$query&limit=5&appid=$API_KEY'),
    );

    // If the request is successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body);
      // Map the data to a list of strings in the format "City, Country"
      return data.map((city) => "${city['name']}, ${city['country']}").toList();
    } else {
      // Throw an exception if the request fails
      throw Exception('Failed to load city suggestions');
    }
  }
}