import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import  'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
  
}
final myController = TextEditingController();

class MyApp extends StatelessWidget {
 const  MyApp({super.key});
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
                  child: 
              const Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                  controller: myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'If you would like to sync the app with your calendar, enter the link here.\n',
                ),
              ),
            ),

        Align(
         alignment: Alignment.centerRight,
          child:
            ElevatedButton(
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
           // ------------------------- Update ------------------------ 
            // Usage of the calendarFiltered
            List<Cal> calendarFiltered=getCal();
            for(int i=0;i<calendarFiltered.length;i++){
              calendarFiltered[i].printClassForDebug();
            }
            // ------------------------- Update ------------------------ 
          },
            child: const Text('Submit'),
        ),),
        
        ElevatedButton(
          child: const Text('Go Back!'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
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

    return MaterialApp(
        title: 'Calendar Sync',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Calendar Sync'),
            ),
            body: Column(
              children: [
                titleSection,
              ],
            ))
        // const MyHomePage(title: 'Flutter Demo Home Page'),
        );
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


class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page (Demo)'),
        
      ),
      body:Column(
        children:  [ElevatedButton(
          onPressed: ()  {
          Navigator.pop(context);
          },
          child: const Text('Go back!'),
          
        ),

        ]
      ),
      
    );
  }
}



// ------------------------- Update ------------------------ 

// get the full list of filtered and sorted Calendar objects from [] to pretty much a lot!
List<Cal> getCal(){
 // print(currentTimeStampiCal());
  List<Cal> calendarFiltered=[];

  addCalToList(icalInput1,calendarFiltered);
  addCalToList(icalInput2,calendarFiltered);
  addCalToList(icalInput3,calendarFiltered);

  // print(calendarFiltered.length);
  calendarFiltered.sort((a, b) => a.startTime.compareTo(b.startTime));

  return calendarFiltered;
}
// Json Demo:
// {
//     "version":"2.0",
//     "prodid":"-//hacksw/handcal//NONSGML v1.0//EN",
//     "calscale":"GREGORIAN",
//     "method":"PUBLISH",
//     "data":[
//         {"type":"VEVENT",
//         "created":{"dt":"19960329T133000Z"},
//         "uid":"uid1@example.com",
//         "dtstamp":{"dt":"19970714T170000Z"},
//         "organizer":{"name":"John Doe","mail":"john.doe@example.com"},
//         "dtstart":{"dt":"19970714T170000Z"},
//         "dtend":{"dt":"19970715T035959Z"},
//         "summary":"Bastille Day Party",
//         "geo":{"latitude":48.85299,
//         "longitude":2.36885}}]
// }       
class Cal {
  final double latitude;
  final double longitude;
  final String summary;
  final String startTime;
  final String endTime;

  const Cal({
    required this.summary,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,

  });
    
    factory Cal.fromJson(Map<String, dynamic> json) {
    return Cal(
      summary: json['data'][0]['summary'] as String,
      latitude: json['data'][0]['geo']['latitude'] as double,
      longitude: json['data'][0]['geo']['longitude'] as double,
      startTime: json['data'][0]['dtstart']['dt'] as String,
      endTime: json['data'][0]['dtend']['dt'] as String
    );  
  }

  void printClassForDebug(){
        print(this.latitude);print(this.longitude);print(this.summary);
        print(this.startTime);print(this.endTime);
  }
}
// Util function:
String currentTimeStampiCal()
{
    // String datetime = DateTime.now().toString();
    // print(datetime);
    String cdate = DateFormat("yyyyMMdd").format(DateTime.now());
    // print(cdate);
    String tdata = DateFormat("HHmmss").format(DateTime.now());
    // print(tdata);
    String fullTime=cdate+'T'+tdata+'Z';
    // print(fullTime);
    return fullTime;
}
Cal strToCalendarClass(String icalInput){
    final iCalendar = ICalendar.fromString(icalInput);
    // print(iCalendar);
    // print(iCalendar.toJson());
    final iCalJson=iCalendar.toJson();
    // final list = List<Cal>.from(iCalJson.map((x) => Cal.fromJson(x)));
      //  print(list);
    Cal cal=Cal.fromJson(iCalJson);
    return cal;
}

void addCalToList(String calStr,List<Cal> calendarFiltered){
      Cal cal=strToCalendarClass(calStr);
        // cal.printClassForDebug();
      if(cal.startTime.compareTo(currentTimeStampiCal())==1){ 
          calendarFiltered.add(cal);
      }
}

String icalInput1 =
"""BEGIN:VCALENDAR
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
  String icalInput2 =
"""BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:20230520T170000Z
DTEND:20230520T185959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
END:VCALENDAR
""";
  String icalInput3 =
"""BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
CREATED:19960329T133000Z
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:20230519T170000Z
DTEND:20230519T185959Z
SUMMARY:Bastille Day Party
GEO:48.85299;2.36885
END:VEVENT
END:VCALENDAR
"""; 


// ------------------------- Update ------------------------ 