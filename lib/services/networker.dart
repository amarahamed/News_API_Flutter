/*
* Networker helps to fetched data from any api link and converts into usable data
* */
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networker {
  String url;

  Networker(this.url);

  Future<dynamic> getNews() async {
    // normalize url
    Uri uri = Uri.parse(url);

    http.Response response = await http.get(uri);

    dynamic decodedData;

    if (response.statusCode == 200) {
      // decode JSON data
      decodedData = jsonDecode(response.body);
    } else {
      print("Error fetching data from API");
    }

    return decodedData;
  }
}
