import 'package:flutter/material.dart';

/// A widget that creates an animated background gradient
class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  final Widget child;

  const AnimatedBackground({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  /// Determines the gradient colors based on the current time of day
  ///
  /// @return A list of two colors for the gradient
  List<Color> _getGradientColors() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return [Colors.lightBlue[300]!, Colors.lightBlue[100]!]; // Morning colors
    } else if (hour >= 12 && hour < 17) {
      return [Colors.blue[400]!, Colors.blue[100]!]; // Afternoon colors
    } else if (hour >= 17 && hour < 20) {
      return [Colors.orange[400]!, Colors.deepOrange[100]!]; // Evening colors
    } else {
      return [Colors.indigo[400]!, Colors.indigo[100]!]; // Night colors
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getGradientColors(),
              stops: [
                controller.value,
                controller.value + 0.3,
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}