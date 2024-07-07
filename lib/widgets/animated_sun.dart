import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A widget that displays an animated sun icon
class AnimatedSun extends StatelessWidget {
  final AnimationController controller;

  const AnimatedSun({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Rotate the sun icon based on the animation controller's value
        return Transform.rotate(
          angle: controller.value * 2 * 3.14, // Full rotation (2π radians)
          child: Icon(WeatherIcons.day_sunny, size: 80, color: Colors.yellow[600]),
        );
      },
    )
    // Apply additional animations using flutter_animate package
        .animate()
        .fadeIn(duration: 800.ms) // Fade in animation
        .scale() // Scale animation
        .shimmer(duration: 2000.ms, color: Colors.white); // Shimmer effect
  }
}