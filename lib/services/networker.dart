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

      // checks if image provided by the api is valid else add my own placeholder
      int index = 0;
      for (var x in decodedData["articles"]) {
        final http.Response imgResponse = await http.get(Uri.parse(x["image"]));
        if (imgResponse.statusCode == 404) {
          decodedData["articles"][index]["image"] =
              "https://www.androkit.com/wp-content/uploads/2022/06/404-Page-Not-Found.webp";
        }
        index++;
      }
    } else {
      print("Error fetching data from API");
    }

    return decodedData;
  }
}
