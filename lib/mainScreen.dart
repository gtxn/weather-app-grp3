import "package:flutter/material.dart";
import "package:weather/weather.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get.dart";
import  "package:intl/intl.dart";

// OpenWeatherMap Direct Call Structure: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}

// MAIN SCREEN STRUCTURE

// Container {
// -- DateTime Widget
// -- ButtonArray Widget {
// -- -- SunButton1
// -- -- WindButton1
// -- -- RainButton1
// -- }
// }

// Container {
// -- iCalHookSymbol/TextLabel/PaddedLabel/ExpandButton
// }

// Container {
// -- Cardholder {
// -- -- PaddedLabel
// -- -- ScrollBar
// -- -- Container {
// -- -- -- NEXT HOUR / EVENT WEATHER CARDS ***
// -- -- }
// -- }
// }

// Container {
// -- PaddedLabel (linked to page state)
// -- PaddedBox {
//


// WEATHER CARD STRUCTURE
// -- Container
  // -- BoxDecoration (rounded edges / shadows etc.)
// -- Column
  // -- Container (to keep shape of box)
    // -- Row
      // -- Container (to hold actual items)
        // -- Text (Day of week)
      // -- Some sort of Line / Separator
      // -- SizedBox (For weather Icon)
        // -- IconButton (to display more info for certain type of weather)
          // -- Icon
      // -- SizedBox (For temp. info)
        // -- TextButton (to display actual temperature)
          // -- Text


class DataFetcher {
  String weatherAPIKey = "faf1a6694dd9228171823c05d2a874d8";
  String calAPIKey = "";
  String? iCal;
  Weather? currentWeather;
  double? lat, lon;
  WeatherFactory? wf;

  DataFetcher(double this.lat, double this.lon) {
    wf = WeatherFactory(weatherAPIKey);
  }

  void updateWeather() async {
    wf ??= WeatherFactory(weatherAPIKey);
    currentWeather = await wf?.currentWeatherByLocation(lat!, lon!);
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    throw UnimplementedError();
  }

}
