import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/components/ListTitleText.dart';

// Takes event

class EventBlock extends StatelessWidget {
  EventBlock(this.event, {super.key});
  final Map event;
  final style = Constants();

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
                title: event['title'],
                fontSize: 20,
              ),
              ListTitleText(
                title: DateFormat('hh:mm').format(event['time']),
                fontSize: 15,
              ),
            ],
          ),
          Icon(getIcon(event['weather']))
        ],
      ),
    );
  }
}
