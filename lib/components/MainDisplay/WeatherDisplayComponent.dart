import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_data.dart';

import '../WeatherOverlay.dart';

class WeatherDisplayComponent extends StatelessWidget {
  const WeatherDisplayComponent(this.now, this.weather, {super.key});

  final DateTime now;
  final Future<WeatherData> weather;

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
                child: FutureBuilder(
                    future: weather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "${(snapshot.data!.general!.current.feelsLike! - 273.15).toStringAsFixed(0)}º",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FutureBuilder(
                  future: weather,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FloatingActionButton(
                        // heroTag: "topWeather",
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => WeatherOverlay(
                                  toggleOpen: () {
                                    Navigator.pop(context);
                                  },
                                  weather: snapshot.data!,
                                )),
                        child: ImageIcon(AssetImage(
                            "lib/assets/${snapshot.data!.general!.current.weather![0].icon}.png")),
                      );
                    }
                    return const FloatingActionButton(
                      onPressed: null,
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
