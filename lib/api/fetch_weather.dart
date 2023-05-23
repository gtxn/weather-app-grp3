import 'dart:convert';
import 'package:weather_app/model/weather_data_event.dart';
import 'package:weather_app/model/weather_data_forecast.dart';

import 'api_key.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data_general.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processWeatherData(latitude, longitude) async {
    var response = await http.get(Uri.parse(apiURL(latitude, longitude)));
    var jsonData = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataGeneral.fromJson(jsonData),
        WeatherDataForecast.fromJson(jsonData),
        WeatherDataEvent.fromJson(jsonData));
    return weatherData!;
  }
}

String apiURL(var latitude, var longitude) {
  return "https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&exclude=minutely&appid=$apiKey";
}
