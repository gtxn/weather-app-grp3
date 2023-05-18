import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/assets/Constants.dart';
import 'components/WeatherOverlay.dart';

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
              ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: Column(
          children: const [
            home,
          ],
        ),
      ),
    );
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
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ElevatedButton(
                onPressed: toggleWeatherModalOpen,
                child: const Text("pressToOpenModal"),
              ),
              WeatherOverlay(
                key: const Key('overlayModal'),
                isVisible: isWeatherModalOpen,
                toggleOpen: toggleWeatherModalOpen,
              ),
            ],
          )
        ],
      ),
    );
  }
}
