import 'package:flutter/material.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/components/ListTitleText.dart';

// Takes in datetime as a paramter as the time for next rain
class NextRainComponent extends StatelessWidget {
  NextRainComponent(this.time, {super.key});

  final style = Constants();
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return (ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: ListTitleText(title: "Time of next rain", color: style.white),
      trailing: Text(
        '${time.hour}:${time.minute}',
        style: TextStyle(
          color: style.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ));
  }
}
