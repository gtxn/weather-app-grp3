class Rain {
  double? one_hour;

  Rain({this.one_hour});

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        one_hour: (json['1h'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        '1h': one_hour,
      };
}
