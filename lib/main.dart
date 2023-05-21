import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/components/MainDisplay/EventComponent.dart';
import 'package:weather_app/components/MainDisplay/NextRainComponent.dart';
import 'package:weather_app/components/MainDisplay/WeatherDisplayComponent.dart';
import 'components/ListTitleText.dart';
import 'components/WeatherOverlay.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static Constants style = Constants();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Widget home = MainPage(title: 'test');

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: style.primary,
            scaffoldBackgroundColor: style.bg,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme.copyWith(
                    bodyLarge: TextStyle(color: style.primary[50]),
                    bodyMedium: TextStyle(color: style.primary[50]),
                    displayLarge: TextStyle(
                      color: style.white,
                      fontWeight: FontWeight.w700,
                    ),
                    displayMedium: TextStyle(
                      color: style.white,
                      fontWeight: FontWeight.w700,
                    ),
                    titleLarge: TextStyle(color: style.white),
                    titleMedium: TextStyle(color: style.white),
                    titleSmall: TextStyle(color: style.white),
                  ),
            )),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter layout demo'),
            ),
            body: home));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isWeatherModalOpen = false;
  bool isWindModalOpen = false;

  void toggleWeatherModalOpen() {
    setState(() {
      isWeatherModalOpen = !isWeatherModalOpen;
    });
  }

  void toggleWindModalOpen() {
    setState(() {
      isWindModalOpen = !isWindModalOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          children: [
            WeatherDisplayComponent(now),
            const Divider(),
            ...ListTile.divideTiles(context: context, tiles: [
              NextRainComponent(now),
              EventComponent([
                {
                  'title': 'event1',
                  'time': DateTime.parse('20230521 10:30'),
                  'weather': 1,
                },
                {
                  'title': 'event2',
                  'time': DateTime.parse('20230521 12:30'),
                  'weather': 1,
                },
                {
                  'title': 'event3',
                  'time': DateTime.parse('20230521 14:30'),
                  'weather': 0,
                },
                {
                  'title': 'event4',
                  'time': DateTime.parse('20230521 17:30'),
                  'weather': 0,
                },
              ])
            ]),
          ],
        ),
      ],
    );
  }
}
