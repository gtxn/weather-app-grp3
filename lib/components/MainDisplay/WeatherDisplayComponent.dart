import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../WeatherOverlay.dart';

class WeatherDisplayComponent extends StatelessWidget {
  const WeatherDisplayComponent(this.now, this.temp, {super.key});

  final DateTime now;
  final double temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 150, 0, 50),
      child: Column(
        children: [
          Text(
            DateFormat('dd/MM/yy').format(now),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            DateFormat.E().format(now),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Stack(
            children: [
              Center(
                child: Text(
                  "${temp.toStringAsFixed(0)}º",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  // heroTag: "topWeather",
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          WeatherOverlay(toggleOpen: () {
                            Navigator.pop(context);
                          })),
                  child: const Icon(Icons.sunny),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
