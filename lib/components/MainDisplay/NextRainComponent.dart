import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/components/ListTitleText.dart';
import 'package:weather_app/model/weather_data.dart';

// Takes in datetime as a paramter as the time for next rain
class NextRainComponent extends StatelessWidget {
  NextRainComponent(this.time, {super.key, required this.weather});
  Future<WeatherData> weather;

  final style = Constants();
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return (ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: ListTitleText(title: "Time of next rain", color: style.white),
        trailing: FutureBuilder(
            future: weather,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final hourOfNextRain = snapshot.data!.forecast!.hourly
                    .firstWhereOrNull((hour) => hour.weather![0].id! < 700);
                if (hourOfNextRain != null) {
                  final time = DateTime.fromMillisecondsSinceEpoch(
                      hourOfNextRain.dt! * 1000);
                  return Text(
                    '${time.hour}:${time.minute}',
                    style: TextStyle(
                      color: style.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return Text(
                  'No rain soon!',
                  style: TextStyle(
                    color: style.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              return const CircularProgressIndicator();
            }))));
  }
}
