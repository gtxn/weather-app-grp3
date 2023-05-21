import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/MainDisplay/EventBlock.dart';

import '../../assets/Constants.dart';
import '../ListTitleText.dart';

class EventComponent extends StatelessWidget {
  // Events structure:
  // final events = [
  //   {
  //     'title': STRING,
  //     'time': DATETIME,
  //     'weather': ?? ,
  //   }
  // ];

  EventComponent(this.events, {super.key});

  final style = Constants();
  final events;

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
      title: EventBlock(events[0]),
      backgroundColor: style.primary.shade700,
      collapsedBackgroundColor: style.primary.shade300,
      collapsedTextColor: style.darkGreen,
      textColor: style.white,
      childrenPadding: EdgeInsets.all(5),
      tilePadding: EdgeInsets.all(5),
      children: [
        ...events.sublist(1).map((e) => EventBlock(e)),
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
