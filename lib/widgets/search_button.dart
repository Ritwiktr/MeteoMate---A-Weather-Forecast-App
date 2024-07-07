import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A custom search button widget with animation effects.
class SearchButton extends StatelessWidget {
  /// Callback function to be executed when the button is pressed.
  final VoidCallback onPressed;

  /// Constructor for the SearchButton widget.
  ///
  /// [onPressed] is required and defines the action to be performed when the button is tapped.
  const SearchButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      // Define the action to be performed when the button is pressed
      onPressed: onPressed,
      // Set the icon for the button
      icon: Icon(Icons.search, color: Colors.blue[700]),
      // Set the text label for the button
      label: Text('Search', style: TextStyle(color: Colors.blue[700])),
      // Configure the button's style
      style: ElevatedButton.styleFrom(
        // Set the background color of the button
        backgroundColor: Colors.white,
        // Set the padding inside the button
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        // Set the shape of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // Set the elevation (shadow) of the button
        elevation: 5,
      ),
    )
    // Apply animation effects to the button
        .animate()
    // Fade in the button over 800 milliseconds
        .fadeIn(duration: 800.ms)
    // Scale the button
        .scale()
    // Add a shimmer effect lasting 2000 milliseconds
        .shimmer(duration: 2000.ms);
  }
}
