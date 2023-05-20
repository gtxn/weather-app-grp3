import 'weather_raw/weather.dart';

class WeatherDataEvent {
  int? dt;
  double? temp;
  double? feelsLike;
  List<Weather>? weather;

  WeatherDataEvent({
    this.dt,
    this.temp,
    this.feelsLike,
    this.weather,
  });

  factory WeatherDataEvent.fromJson(Map<String, dynamic> json) =>
      WeatherDataEvent(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.toDouble(),
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feels_like': feelsLike,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
