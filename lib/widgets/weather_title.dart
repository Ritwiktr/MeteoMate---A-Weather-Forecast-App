import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A custom widget for displaying the weather forecast title with animation effects.
class WeatherTitle extends StatelessWidget {
  /// Constructor for the WeatherTitle widget.
  const WeatherTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Weather Forecast',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        // Set the text color to white
        color: Colors.white,
        // Make the text bold
        fontWeight: FontWeight.bold,
        // Add a shadow effect to the text
        shadows: [
          Shadow(
            // Set the blur radius of the shadow
            blurRadius: 10.0,
            // Set the color of the shadow with 30% opacity
            color: Colors.black.withOpacity(0.3),
            // Set the offset of the shadow
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    )
    // Apply animation effects to the text
        .animate()
    // Fade in the text over 800 milliseconds
        .fadeIn(duration: 800.ms)
    // Slide the text vertically from -0.2 to 0
        .slideY(begin: -0.2, end: 0)
    // Chain another animation after the fade and slide
        .then()
    // Add a shimmer effect lasting 2000 milliseconds
        .shimmer(duration: 2000.ms);
  }
}

