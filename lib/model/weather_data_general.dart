import './weather_raw/weather.dart';

class WeatherDataGeneral {
  final Current current;
  WeatherDataGeneral({required this.current});

  factory WeatherDataGeneral.fromJson(Map<String, dynamic> json) =>
      WeatherDataGeneral(current: Current.fromJson(json['current']));
}

class Current {
  int? dt;
  double? temp;
  double? feelsLike;
  List<Weather>? weather;

  Current({
    this.dt,
    this.temp,
    this.feelsLike,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
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
