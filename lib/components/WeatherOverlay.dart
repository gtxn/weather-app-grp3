import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'WeatherOverlay/ListItem.dart';

class WeatherOverlay extends StatelessWidget {
  final void Function() toggleOpen;

  const WeatherOverlay({super.key, required this.toggleOpen});

  @override
  Widget build(BuildContext context) {
    Constants style = Constants();
    List<Widget> items = [];
    DateTime now = DateTime.now();

    // Fake generation of data
    for (int i = 0; i < 24; i++) {
      now = now.add(const Duration(hours: 1));
      String nowStr = DateFormat.H().format(now);
      items.add(ListItem(time: '$nowStr:00', weather: 1));
    }

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
                children: items,
              ),
            ),
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
