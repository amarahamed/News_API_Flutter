/*
* This class organizes what type of data it needs from the networker - passes url as an argument 
* */

import 'package:news_api/services/networker.dart';
import 'package:news_api/utilities/api_keys.dart';

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
