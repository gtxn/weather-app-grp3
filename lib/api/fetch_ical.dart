import 'package:http/http.dart' as http;

class FetchIcal {
  static Future<String> fetchIcal(link) async {
    var response = await http.get(Uri.parse(link));
    response.statusCode == 200
        ? print("Success")
        : print("Error: ${response.statusCode}");
    return response.body;
  }
}
