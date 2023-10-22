import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_api/screens/home_screen.dart';
import 'package:news_api/services/news.dart';
import 'package:news_api/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen(
      {super.key,
      required this.newsType,
      this.searchKeyword,
      this.searchCategory});

  Enum newsType;
  String? searchKeyword;
  String? searchCategory;

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
            .getNewsCategoryHeadlines(widget.searchCategory ?? "general");
      }
    } else {
      // get data if search keyword is not null
      if (widget.searchKeyword == null) {
        print("Search keyword is null");
      } else {
        newsData = await News().getNewsWithKeyword(widget.searchKeyword ?? "");
      }
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
      key: _scaffoldKey,
      body: const Center(
        child: SpinKitFoldingCube(
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
