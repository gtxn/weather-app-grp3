import 'weather_raw/temp.dart';
import 'weather_raw/weather.dart';

class WeatherDataForecast {
  int? dt;
  Temp? temp;
  List<Weather>? weather;

  WeatherDataForecast({
    this.dt,
    this.temp,
    this.weather,
  });

  factory WeatherDataForecast.fromJson(Map<String, dynamic> json) =>
      WeatherDataForecast(
        dt: json['dt'] as int?,
        temp: json['temp'] == null
            ? null
            : Temp.fromJson(json['temp'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
