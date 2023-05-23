import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/fetch_ical.dart';

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
    // print(json);
    String? summary = json['summary'] as String?;
    String? timezone = json['dtstart']['tzid'] as String?;
    String? startTime = json['dtstart']['dt'] as String?;
    String? endTime = json['dtend']['dt'] as String?;

    return Cal(
        summary: summary ?? "",
        // latitude: json['geo']['latitude'] as double,
        // longitude: json['geo']['longitude'] as double,
        timeZone: timezone ?? "",
        startTime: startTime ?? "",
        endTime: endTime ?? "");
  }

  void printClassForDebug() {
    // print(timeZone);
    // print(summary);
    // print(startTime);
    // print(endTime);
  }
}

Future<List<Cal>> getCal(String link) async {
  // print(currentTimeStampiCal());

  final String result = await fetchIcal.fetch(link);
  final ICalendar iCalendar = ICalendar.fromString(result);
  final iCalJson = iCalendar.toJson();
  final List<Cal> calFiltered = [];
  for (int i = 0; i < iCalJson['data'].length; i++) {
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
      calFiltered.add(cal);
      // cal.printClassForDebug();
    }
  }
  return calFiltered;
}

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
