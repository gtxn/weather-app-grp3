import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'WeatherOverlay/ListItem.dart';

class WeatherOverlay extends StatefulWidget {
  bool isVisible = true;
  void Function() toggleOpen;

  WeatherOverlay(
      {required Key key, required this.isVisible, required this.toggleOpen})
      : super(key: key);

  @override
  State<WeatherOverlay> createState() => _WeatherOverlayState();
}

class _WeatherOverlayState extends State<WeatherOverlay> {
  Constants style = Constants();

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    DateTime now = DateTime.now();

    // Fake generation of data
    for (int i = 0; i < 24; i++) {
      now = now.add(const Duration(hours: 1));
      String nowStr = DateFormat.H().format(now);
      items.add(ListItem('$nowStr:00', 1));
    }

    return Visibility(
      visible: widget.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
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
                    onPressed: widget.toggleOpen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0),
                    ),
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
