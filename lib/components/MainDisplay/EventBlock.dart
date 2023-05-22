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

  IconData getIcon(weather) {
    IconData i;

    if (weather == 0) {
      i = Icons.sunny;
    } else if (weather == 1) {
      i = Icons.cloud;
    } else if (weather == 2) {
      i = Icons.umbrella;
    } else {
      i = Icons.snowing;
    }

    return i;
  }

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
                  if (hourly.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ImageIcon(AssetImage(
                      "lib/assets/${hourly.first.weather![0].icon}.png"));
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
