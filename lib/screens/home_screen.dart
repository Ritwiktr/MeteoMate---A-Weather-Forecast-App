import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/weather_service.dart';
import '../services/city_service.dart';
import '../widgets/animated_backgroud.dart';
import '../widgets/animated_sun.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_button.dart';
import '../widgets/weather_title.dart';
import 'weather_details_screen.dart';

/// The main screen of the weather app where users can search for a city's weather.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _sunAnimationController;
  late AnimationController _backgroundAnimationController;
  final CityService _cityService = CityService();

  @override
  void initState() {
    super.initState();

    // Initialize sun animation controller
    _sunAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
    // Initialize background animation controller
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: Duration(minutes: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _sunAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }



  /// Initiates a weather search for the city in the text field
  void _searchWeather() {
    if (_controller.text.isNotEmpty) {
      final weatherService = Provider.of<WeatherService>(context, listen: false);
      weatherService.fetchWeather(_controller.text);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => WeatherDetailsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        controller: _backgroundAnimationController,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top section with animated sun and title
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedSun(controller: _sunAnimationController),
                                SizedBox(height: 20),
                                WeatherTitle(),
                              ],
                            ),
                          ),
                          // Bottom section with search bar and button
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: WeatherSearchBar(
                                    controller: _controller,
                                    onSubmitted: (value) => _searchWeather(),
                                    cityService: _cityService,
                                  ),
                                ),
                                SizedBox(height: 20),
                                SearchButton(onPressed: _searchWeather),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}