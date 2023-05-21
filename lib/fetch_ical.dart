import 'package:http/http.dart' as http;

class fetchIcal {
  static Future<String> fetch(String link) async {
    print(link);
    var response = await http.get(Uri.parse(link));
    response.statusCode == 200
        ? print("Success")
        : print("Error: ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception("Failed to access ical");
    }
    return response.body;
  }
}
