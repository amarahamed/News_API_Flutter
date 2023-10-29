import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_api/screens/home_screen.dart';
import 'package:news_api/screens/search_screen.dart';
import 'package:news_api/services/news.dart';
import 'package:news_api/utilities/utilities.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen(
      {super.key,
      required this.newsType,
      this.searchKeyword,
      this.searchCategory});

  final Enum newsType;
  final String? searchKeyword;
  final String? searchCategory;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // BuildContext
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  News news = News();

  void getNews() async {
    // store fetched news
    dynamic newsData;

    if (widget.newsType == NewsType.headlines) {
      // News data
      newsData = await News().getNewsHeadlines();
      // Push new screen
      Navigator.push(_scaffoldKey.currentContext!,
          MaterialPageRoute(builder: (context) {
        return HomeScreen(newsData: newsData);
      }));
    } else if (widget.newsType == NewsType.headlinesCategorized) {
      if (widget.searchCategory == null) {
        print("Category searched is null");
      } else {
        // get data
        newsData = await News()
            .getNewsCategoryHeadlines(widget.searchCategory ?? "sports");

        Navigator.push(_scaffoldKey.currentContext!,
            MaterialPageRoute(builder: (context) {
          return SearchScreen(
            newsData: newsData,
          );
        }));
      }
    } else if (widget.newsType == NewsType.searchNews) {
      newsData =
          await News().getNewsWithKeyword(widget.searchKeyword ?? "example");

      Navigator.push(_scaffoldKey.currentContext!,
          MaterialPageRoute(builder: (context) {
        return SearchScreen(
          newsData: newsData,
        );
      }));
    } else {
      newsData = await News().getNewsHeadlines();

      Navigator.push(_scaffoldKey.currentContext!,
          MaterialPageRoute(builder: (context) {
        return SearchScreen(
          newsData: newsData,
        );
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      key: _scaffoldKey,
      body: const Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

/*
*
*
* */
