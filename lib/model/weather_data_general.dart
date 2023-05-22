class WeatherDataGeneral {
  final Current current;
  WeatherDataGeneral({required this.current});

  factory WeatherDataGeneral.fromJson(Map<String, dynamic> json) =>
      WeatherDataGeneral(current: Current.fromJson(json['current']));
}

class Current {
  double? feelsLike;

  Current({
    this.feelsLike,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'feels_like': feelsLike,
      };
}
