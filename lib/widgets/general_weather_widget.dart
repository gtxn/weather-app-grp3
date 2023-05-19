import 'package:flutter/widgets.dart';
import '../model/weather_data_general.dart';

class GeneralWeatherWidget extends StatelessWidget {
  final WeatherDataGeneral weatherDataGeneral;

  const GeneralWeatherWidget({super.key, required this.weatherDataGeneral});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
            'Temperature:${weatherDataGeneral.current.feelsLike! - 273.15} °C'));
  }
}
