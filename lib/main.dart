import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/assets/Constants.dart';
import 'components/WeatherOverlay.dart';
import 'package:intl/intl.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:intl/intl.dart';

import 'fetch_ical.dart';
import 'package:weather_app/components/MainDisplay/EventComponent.dart';
import 'package:weather_app/components/MainDisplay/NextRainComponent.dart';
import 'package:weather_app/components/MainDisplay/WeatherDisplayComponent.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

//input text box (iCal link from user, global var)
final myController = TextEditingController();
List<Cal> calendarFiltered = [];

class PeterPage extends StatelessWidget {
  const PeterPage({super.key});
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Welcome to integrate your lectures with your weather APP! \n \nYour iCal URL contains a secure token that prevents other people from accessing the events in your diary. You can deliberately share it with other people if you wish to let them see what is on your calendar.\n\nHow to find it?  Good question!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Google Calendar: under "Other Calendars", choose "Add by URL" and paste your URL.\n  \nMicrosoft Outlook: on the Home Tab in Outlook 2016, click the "Open Calendar" dropdown. Select "From Internet" and paste your URL.\n \nApple Calendar: on the File menu, select "Add Calendar Subscription..." and paste your URL.\nQuoted with thanks from KuDoS system.\n \nFor other situations, please have a search online.\n \n ',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                const Text(
                  'Enter your iCal link here:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'If you would like to sync the app with your calendar, enter the link here.\n',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // background
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the that user has entered by using the
                            // TextEditingController.
                            content: Text("Received iCal:${myController.text}"),
                          );
                        },
                      );
                      // ------------------------- Update -----------------------
                      getCalAsync();
                      // ------------------------- Update ------------------------
                    },
                    child: const Text('Submit'),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Go Back!'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondRoute()),
                    );
                  },
                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );
    return titleSection;
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page (Demo)'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ]),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static Constants style = Constants();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget home = MainPage();

    return MaterialApp(
        title: 'Calendar Sync',
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
              title: const Text('Calendar Sync'),
            ),
            body: home));
  }
}
// Future<void> parseIcsFile(String filePath) async {
//     final lines = await File(filePath).readAsLines();

//     final json = ICalendar.fromLines(lines).toJson();
//     final buffer = StringBuffer('File: $filePath\n');
//     final prettyprint = const JsonEncoder.withIndent('  ').convert(json);
//     buffer.writeln(prettyprint);
//     print(buffer.toString());
//   }
// Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }
// DEMO Page

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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

// ------------------------- Update ------------------------
class Cal {
  // final double latitude;
  // final double longitude;
  final String summary;
  final String timeZone;
  final String startTime;
  final String endTime;

  const Cal(
      {
      // required this.latitude,
      // required this.longitude,
      required this.summary,
      required this.startTime,
      required this.endTime,
      required this.timeZone});

  factory Cal.fromJson(Map<String, dynamic> json) {
    return Cal(
        summary: json['summary'] as String,
        // latitude: json['geo']['latitude'] as double,
        // longitude: json['geo']['longitude'] as double,
        timeZone: json['dtstart']['tzid'] as String,
        startTime: json['dtstart']['dt'] as String,
        endTime: json['dtend']['dt'] as String);
  }

  void printClassForDebug() {
    print(timeZone);
    print(summary);
    print(startTime);
    print(endTime);
  }
}

//---------------------------- Util function:---------------------------
String currentTimeStampiCal() {
  // String datetime = DateTime.now().toString();
  // print(datetime);
  String cdate = DateFormat("yyyyMMdd").format(DateTime.now());
  // print(cdate);
  String tdata = DateFormat("HHmmss").format(DateTime.now());
  // print(tdata);
  String fullTime = '${cdate}T$tdata';
  // print(fullTime);
  return fullTime;
}

String iCalStr = "";
String inputlink = myController.text;

// get the full list of filtered and sorted Calendar objects from [] to pretty much a lot!
void getCalAsync() async {
  calendarFiltered = await getCal();
  print(calendarFiltered);
  for (int i = 0; i < min(calendarFiltered.length, 10); i++) {
    calendarFiltered[i].printClassForDebug();
  }
}

Future<List<Cal>> getCal() {
  // print(currentTimeStampiCal());
  ICalendar iCalendar;
  var calendarFiltered = fetchIcal.fetch(inputlink).then((String result) {
    // print(result);
    List<Cal> calendarFiltered = [];
    iCalStr = result;
    iCalendar = ICalendar.fromString(iCalStr);

    final iCalJson = iCalendar.toJson();
    // print(iCalJson);
    // print(iCalJson['data']);
    // print(iCalJson['data'].length);
    for (int i = 0; i < iCalJson['data'].length; i++) {
      // print(iCalJson['data'][i]['type']);

      if (iCalJson['data'][i]['type'] != 'VEVENT') {
        continue;
      }
      // print(iCalJson['data'][i]['summary']);
      // print(iCalJson['data'][i]['dtstart']['tzid']);
      // print(iCalJson['data'][i]['dtstart']['dt']);
      // print(iCalJson['data'][i]['dtend']['dt']);

      Cal cal = Cal.fromJson(iCalJson['data'][i]);
      //cal.printClassForDebug();

      if (cal.startTime.compareTo(currentTimeStampiCal()) == 1) {
        calendarFiltered.add(cal);
        // cal.printClassForDebug();
      }
    }
    calendarFiltered.sort((a, b) => a.startTime.compareTo(b.startTime));
    return calendarFiltered;
    // print(calendarFiltered.length);
    // calendarFiltered.sort((a, b) => a.startTime.compareTo(b.startTime));
  });
  return calendarFiltered;
}

// Sample iCal input string
String icalInput = """BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:19970714T170000Z
DTEND:19970715T035959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:20230526T170000Z
DTEND:20230526T185959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:20230528T170000Z
DTEND:20230528T185959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
END:VCALENDAR
""";
String icalInput1 = """BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:19970714T170000Z
DTEND:19970715T035959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
END:VCALENDAR
""";
String icalInput2 = """BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:20230526T170000Z
DTEND:20230526T185959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
END:VCALENDAR
""";
String icalInput3 = """BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:20230528T170000Z
DTEND:20230528T185959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
END:VCALENDAR
""";

// ------------------------- Update ------------------------
