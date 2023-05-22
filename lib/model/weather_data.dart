import 'weather_data_event.dart';
import 'weather_data_forecast.dart';
import 'weather_data_general.dart';

class WeatherData {
  final WeatherDataGeneral? general;
  final WeatherDataForecast? forecast;
  final WeatherDataEvent? event;

  WeatherData([this.general, this.forecast, this.event]);

  WeatherDataGeneral getGeneralWeatherData() => general!;
  WeatherDataForecast getForecastWeatherData() => forecast!;
  WeatherDataEvent getEventWeatherData() => event!;
}
