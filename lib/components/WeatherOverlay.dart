import 'package:flutter/material.dart';
import 'package:weather_app/assets/Constants.dart';

class ListItem extends StatelessWidget {
  String time = "";
  int weather = -1; // 0: sunny, 1: rainy

  ListItem(this.time, this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        // decoration: BoxDecoration(

        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(time),
            Icon(weather == 0 ? Icons.sunny : Icons.umbrella),
          ],
        ));
  }
}

class WeatherOverlay extends StatefulWidget {
  const WeatherOverlay({super.key});

  @override
  State<WeatherOverlay> createState() => _WeatherOverlayState();
}

class _WeatherOverlayState extends State<WeatherOverlay> {
  Constants style = Constants();

  @override
  Widget build(BuildContext context) {
    List<ListItem> items = [];

    for (int i = 0; i < 12; i++) {
      items.add(ListItem('$i pm', 1));
    }

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.fromLTRB(10, 15, 15, 10),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: style.gray)],
          borderRadius: BorderRadius.circular(20),
          color: style.primary[50],
        ),
        child: Column(
          children: items,
        ));
  }
}
