import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/calendar_ops.dart';
import 'package:weather_app/components/ListTitleText.dart';
import 'package:weather_app/model/weather_data.dart';

// Takes event

class EventBlock extends StatelessWidget {
  EventBlock(this.event, this.weather, {super.key});
  final Cal event;
  final style = Constants();
  final Future<WeatherData> weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTitleText(
                title: event.summary,
                fontSize: 20,
              ),
              ListTitleText(
                title:
                    DateFormat('hh:mm').format(DateTime.parse(event.startTime)),
                fontSize: 15,
              ),
            ],
          ),
          FutureBuilder(
              future: weather,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final hourly = snapshot.data!.event!.hourly.where((element) {
                    final eventTime = DateTime.parse(event.startTime);
                    final hourlyWeatherTime =
                        DateTime.fromMillisecondsSinceEpoch(element.dt! * 1000);
                    return eventTime.isBefore(hourlyWeatherTime);
                  });
                  if (hourly.isNotEmpty) {
                    return TempWeatherRect(
                        temp: hourly.first.feelsLike! - 273.15,
                        icon: hourly.first.weather![0].icon!);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }))
        ],
      ),
    );
  }
}

// creds to jeremiah
class TempWeatherRect extends StatelessWidget {
  final double temp;
  final String icon;
  const TempWeatherRect({super.key, required this.temp, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Center(
            child: Row(
          children: [
            ImageIcon(AssetImage("lib/assets/$icon.png")),
            Text(
              "${temp.toStringAsFixed(0)}°",
              textAlign: TextAlign.center,
            )
          ],
        )));
  }
}
