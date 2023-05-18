import 'weather_raw/weather.dart';

class Hourly {
  int? dt;
  double? temp;
  double? feelsLike;
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.weather,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
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
