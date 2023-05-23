import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/model/weather_data.dart';

import 'WeatherOverlay/ListItem.dart';

class WeatherOverlay extends StatelessWidget {
  final void Function() toggleOpen;

  const WeatherOverlay(
      {super.key, required this.toggleOpen, required this.weather});
  final WeatherData weather;

  @override
  Widget build(BuildContext context) {
    Constants style = Constants();
    List<Widget> items = [];
    DateTime now = DateTime.now();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.fromLTRB(10, 35, 10, 10),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: style.gray)],
                  borderRadius: BorderRadius.circular(20),
                  color: style.primary[50],
                ),
                width: 450,
                height: 600,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    ...weather.forecast!.hourly.map((h) => ListItem(
                        time: DateFormat("HH:mm").format(
                            DateTime.fromMillisecondsSinceEpoch(h.dt! * 1000)),
                        icon: h.weather![0].icon!))
                  ],
                )),
            Positioned(
              right: 20,
              top: 20,
              child: ElevatedButton(
                onPressed: toggleOpen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0),
                ),
                child: const Icon(
                  Icons.close,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
