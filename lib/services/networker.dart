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
        if (imgResponse.statusCode >= 400 && imgResponse.statusCode < 500) {
          print("Image Not found");
          decodedData["articles"][index]["image"] =
              "https://img.freepik.com/free-vector/404-error-with-person-looking-concept-illustration_114360-7912.jpg?w=1380&t=st=1698894274~exp=1698894874~hmac=6a69fb5708cf041b94fce103ff93e7664983f688aaad53137d4dc5ba2a61e883";
        }
        index++;
      }
    } else {
      print("Error fetching data from API");
    }

    return decodedData;
  }
}
