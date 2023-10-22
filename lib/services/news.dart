/*
* This class organizes what type of data it needs from the networker - passes url as an argument 
* */

import 'package:news_api/services/networker.dart';

const String newsApiKey = "6eed563931144b6f9d1246a4140399d2";
const String qNewsApiKey = "544f88b6146d2ffa3c1485831ba4b43a";

class News {
  String newsAPIURL = "https://newsapi.org/v2/";
  String qNewsAPIURL = "https://gnews.io/api/v4/";
  // https://newsapi.org/v2/top-headlines/sources?apiKey=

  Future<dynamic> getNewsHeadlines() {
    String url =
        "${qNewsAPIURL}top-headlines?category=general&apikey=$qNewsApiKey&lang=en";

    Networker networker = Networker(url);

    return networker.getNews();
  }

  Future<dynamic> getNewsCategoryHeadlines(String category) {
    String url =
        "${qNewsAPIURL}top-headlines?category=$category&apikey=$qNewsApiKey&lang=en";

    Networker networker = Networker(url);

    return networker.getNews();
  }

  Future<dynamic> getNewsWithKeyword(String searchedWord) {
    String url = "${newsAPIURL}everything?q=$searchedWord&apiKey=$newsApiKey";

    Networker networker = Networker(url);

    return networker.getNews();
  }
}

/*

  Future<dynamic> getNewsCategoryHeadlines(String category) {
    // get headlines not for a specific country
    String url = "${newsAPIURL}top-headlines/sources?apiKey=$apiKey";

    // Get data from Networker by passing URL
    Networker networker = Networker(qNewsAPIUrl);

    return networker.getNews();
  }

* */
