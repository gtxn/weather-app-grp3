import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/assets/Constants.dart';
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

    var now = DateTime.now();

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: style.primary,
            scaffoldBackgroundColor: style.bg,
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme.copyWith(
                    bodyLarge: TextStyle(color: style.primary[50]),
                  ),
            )),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter layout demo'),
            ),
            body: const Column(
              children: [
                home,
              ],
            ))
        // const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class DronPage extends StatelessWidget {
  const DronPage({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      children: [
        Container(
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
                      "18º",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      // heroTag: "topWeather",
                      onPressed: () => {},
                      child: const Icon(Icons.sunny),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const Divider(),
        ...ListTile.divideTiles(context: context, tiles: [
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: ListTitleText(title: "time of next rain"),
            trailing: ListTitleText(title: "10am"),
          ),
          ExpansionTile(
            title: const ListTitleText(title: "Next event 1"),
            children: [
              ...[for (var i = 2; i <= 10; i++) i].map((e) => ListTile(
                    title: ListTitleText(title: "Next event $e"),
                  )),
              Builder(builder: (BuildContext context) {
                return IconButton.filled(
                    onPressed: () {
                      return ExpansionTileController.of(context).collapse();
                    },
                    icon: const Icon(Icons.arrow_drop_up));
              })
            ],
          )
        ]),
      ],
    );
  }
}

class ListTitleText extends StatelessWidget {
  const ListTitleText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
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
              // const DronPage(),
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
