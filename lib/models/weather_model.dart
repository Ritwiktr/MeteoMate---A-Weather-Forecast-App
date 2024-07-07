/// A model class representing weather information.
class WeatherModel {
  /// The name of the city.
  final String cityName;

  /// The current temperature.
  final double temperature;

  /// The general weather condition (e.g., "Cloudy", "Sunny").
  final String condition;

  /// The code for the weather icon.
  final String iconCode;

  /// The humidity percentage.
  final int humidity;

  /// The wind speed.
  final double windSpeed;

  /// Constructor for creating a WeatherModel instance.
  ///
  /// All parameters are required.
  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  });

  /// Factory constructor to create a WeatherModel instance from JSON data.
  ///
  /// [json] is a Map containing the weather data from an API response.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      iconCode: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
