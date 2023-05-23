import 'package:flutter/material.dart';
import 'package:weather_app/calendar_ops.dart';
import 'package:weather_app/components/MainDisplay/EventBlock.dart';
import 'package:weather_app/model/weather_data.dart';

import '../../assets/Constants.dart';

class EventComponent extends StatelessWidget {
  // Events structure:
  // final events = [
  //   {
  //     'title': STRING,
  //     'time': DATETIME,
  //     'weather': ?? ,
  //   }
  // ];

  EventComponent(this.events, this.weather, {super.key});

  final style = Constants();
  final List<Cal> events;
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
    return ExpansionTile(
      title: EventBlock(events[0], weather),
      backgroundColor: style.primary.shade700,
      collapsedBackgroundColor: style.primary.shade300,
      collapsedTextColor: style.darkGreen,
      textColor: style.white,
      childrenPadding: const EdgeInsets.all(5),
      tilePadding: const EdgeInsets.all(5),
      children: [
        ...events.sublist(1).map((e) => EventBlock(e, weather)),
        Builder(builder: (BuildContext context) {
          return IconButton.filled(
              onPressed: () {
                return ExpansionTileController.of(context).collapse();
              },
              icon: const Icon(Icons.arrow_drop_up));
        })
      ],
    );
  }
}
