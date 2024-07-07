import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';

import '../services/city_service.dart';

/// A custom search bar widget for searching cities and displaying suggestions
class WeatherSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final CityService cityService;

  const WeatherSearchBar({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.cityService,
  }) : super(key: key);

  @override
  _WeatherSearchBarState createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  bool _isFocused = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isFocused ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.controller,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Search for a city...',
                hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.white70),
                  onPressed: () {
                    widget.controller.clear();
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            suggestionsCallback: (pattern) async {
              // Debounce the suggestions callback to reduce API calls
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              return await Future.delayed(Duration(milliseconds: 300), () async {
                return await widget.cityService.getCitySuggestions(pattern);
              });
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(
                  suggestion,
                  style: TextStyle(color: Colors.black87),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              widget.controller.text = suggestion;
              widget.onSubmitted(suggestion);
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(15),
              elevation: 8.0,
              color: Colors.white.withOpacity(0.9),
            ),
            animationDuration: Duration(milliseconds: 300),
          ),
        ),
      ).animate()
          .fadeIn(duration: 800.ms)
          .slideY(begin: 0.2, end: 0)
          .then()
          .shimmer(duration: 1200.ms, color: Colors.white.withOpacity(0.3)),
    );
  }
}