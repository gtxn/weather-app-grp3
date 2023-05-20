import 'package:http/http.dart' as http;

class FetchIcal {
  Future<dynamic> fetchIcal(link) async {
    var response = await http.get(Uri.parse(link));
    response.statusCode == 200
        ? print("Success")
        : print("Error: ${response.statusCode}");
    return response.body;
  }
}
