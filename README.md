# MeteoMate

MeteoMate is a Flutter-based weather forecast application that provides real-time weather information for locations worldwide.

## Features

- **Home Screen**: Features a search bar for easy location input
- **Weather Screen**: Displays detailed weather information, including:
    - Live weather conditions
    - Current temperature
    - Humidity levels
    - Wind speed
- Smart location search with autocomplete suggestions
- Animated weather icons and text
- Smooth transitions and animations throughout the app

## Getting Started

To run this project locally:

1. Ensure you have Flutter (>=3.4.3) installed on your machine.
2. Clone this repository: `git clone https://github.com/yourusername/meteomate.git`
3. Navigate to the project directory: `cd meteomate`
4. Install dependencies: `flutter pub get`
5. Run the app: `flutter run`

## Usage

1. Launch the app to view the home screen.
2. Use the search bar to enter a location. The app will provide autocomplete suggestions as you type.
3. Select a location or tap the search button to navigate to the Weather Screen.
4. View detailed weather information for the selected location, complete with animated icons and text.

## Dependencies

This project uses the following major dependencies:

- provider: ^6.0.0 (For state management)
- http: ^0.13.3 (For making API requests)
- shared_preferences: ^2.0.7 (For local data storage)
- flutter_spinkit: ^5.1.0 (For loading animations)
- animated_text_kit: ^4.2.2 (For text animations)
- flutter_animate: ^4.1.1+1 (For general animations)
- flutter_typeahead: ^4.3.7 (For search autocomplete functionality)
- weather_icons: ^3.0.0 (For weather-specific icons)

## API

This app uses a weather API to fetch data. You'll need to sign up for an API key from a weather data provider and add it to the project.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.



## Additional Resources

For more information on Flutter development:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Online documentation](https://docs.flutter.dev/)