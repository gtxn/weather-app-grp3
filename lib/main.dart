import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/assets/Constants.dart';
import 'package:weather_app/calendar_ops.dart';

import 'package:weather_app/components/MainDisplay/EventComponent.dart';
import 'package:weather_app/components/MainDisplay/NextRainComponent.dart';
import 'package:weather_app/components/MainDisplay/WeatherDisplayComponent.dart';
import 'package:weather_app/model/weather_data.dart';

import 'components/IcalInputPage/IcalInstructions.dart';
import 'components/IcalInputPage/IcalSubmission.dart';

void main() {
  runApp(const MyApp());
}

//input text box (iCal link from user, global var)
final myController = TextEditingController();
List<Cal> calendarFiltered = [];

// Input screen for ical
class IcalInputScreen extends StatelessWidget {
  static Constants style = Constants();
  const IcalInputScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*2*/
                IcalSubmission(
                  style: style,
                  myController: myController,
                ),
                const IcalInstructions(),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );
    return Scaffold(body: titleSection);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static Constants style = Constants();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calendar Sync',
        theme: ThemeData(
            primarySwatch: style.primary,
            scaffoldBackgroundColor: style.bg,
            textTheme: GoogleFonts.latoTextTheme().copyWith(
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
            colorScheme: ColorScheme.fromSeed(seedColor: style.primary),
            useMaterial3: true),
        home: const Scaffold(body: MainPage()));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _ical = "";
  late Future<List<Cal>> futureFilteredCal;
  // final GlobalController globalController =
  //     Get.put(GlobalController(), permanent: true);
  late Future<WeatherData> asyncWeather;

  @override
  void initState() {
    super.initState();
    _loadical().then((_) => futureFilteredCal = getCal(_ical));
    asyncWeather = _getWeather();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureFilteredCal = getCal(_ical);
  }

  Future<void> _loadical() async {
    final prefs = await SharedPreferences.getInstance();
    final String ical = prefs.getString("ical") ?? "";
    if (ical != "") {
      setState(() {
        _ical = ical;
        prefs.setString("ical", ical);
      });
    } else {
      if (context.mounted) {
        final link = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const IcalInputScreen()));
        setState(() {
          _ical = link;
          prefs.setString("ical", link);
        });
        futureFilteredCal = getCal(_ical);
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<WeatherData> _getWeather() async {
    final pos = await _determinePosition();
    return FetchWeatherAPI().processWeatherData(pos.latitude, pos.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          children: [
            WeatherDisplayComponent(now, asyncWeather),
            const Divider(),
            ...ListTile.divideTiles(context: context, tiles: [
              NextRainComponent(
                now,
                weather: asyncWeather,
              ),
              FutureBuilder<List<Cal>>(
                  future: futureFilteredCal,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return EventComponent(snapshot.data!, asyncWeather);
                    } else {
                      return Center(
                        child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const CircularProgressIndicator()),
                      );
                    }
                  })
            ]),
          ],
        ),
      ],
    );
  }
}
