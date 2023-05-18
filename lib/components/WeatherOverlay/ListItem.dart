import 'package:flutter/material.dart';
import '../../assets/Constants.dart';

class ListItem extends StatelessWidget {
  String time = "";
  int weather = -1; // 0: sunny, 1: cloudy, 2: rainy
  Constants style = Constants();

  // The time is a string
  ListItem(this.time, this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    var iconArray = [Icons.sunny, Icons.cloud, Icons.umbrella];

    return Container(
        padding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: style.darkGreen,
              width: 2,
            ),
          ),
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: style.darkGreen,
                  fontSize: 25,
                ),
              ),
              Icon(iconArray[weather]),
            ],
          ),
        ));
  }
}
