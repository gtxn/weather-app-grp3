import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:intl/date_symbol_data_local.dart';

class ListItem extends StatelessWidget {
  String time = "";
  int weather = -1; // 0: sunny, 1: rainy
  Constants style = Constants();

  ListItem(this.time, this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
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
              Icon(weather == 0 ? Icons.sunny : Icons.umbrella),
            ],
          ),
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
  bool _isVisible = false;

  void _toggleState() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 24; i++) {
      now = now.add(const Duration(hours: 1));
      String nowStr = DateFormat.H().format(now);
      items.add(ListItem('${nowStr}:00', 1));
    }

    return Expanded(
      child: Visibility(
        visible: _isVisible,
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
                    // TODO: close button implementation
                    child: IconButton(
                      onPressed: _toggleState,
                      icon: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
