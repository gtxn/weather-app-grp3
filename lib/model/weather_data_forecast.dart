import 'weather_raw/temp.dart';
import 'weather_raw/weather.dart';

class Daily {
  int? dt;
  Temp? temp;
  List<Weather>? weather;

  Daily({
    this.dt,
    this.temp,
    this.weather,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
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
