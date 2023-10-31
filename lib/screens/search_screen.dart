import 'package:flutter/material.dart';
import 'package:news_api/screens/loading_screen.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/drawer_listview.dart';
import 'package:news_api/utilities/list_container.dart';
import 'package:news_api/utilities/utilities.dart';

import 'news_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.newsData});

  final dynamic newsData;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dynamic news;

  List<String> categories = [
    "All",
    "World",
    "Sports",
    "Nation",
    "Business",
    "Science",
    "Tech",
    "Health",
    "Entertainment"
  ];

  List<dynamic> newsList = [];
  String errText = "";

  @override
  void initState() {
    super.initState();
    news = widget.newsData["articles"];
    // converts news to a dynamic list
    for (var e in news) {
      newsList.add(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DrawerListView(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ));
              }),
              backgroundColor: Colors.transparent,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Find",
                      style: kTitleTextTitle,
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16, top: 8)),
                    TextField(
                      maxLength: 20,
                      onChanged: (value) {
                        if (value.length >= 20) {
                          setState(() {
                            errText = "Maximum 20 characters allowed";
                          });
                        }
                      },
                      onSubmitted: (value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoadingScreen(
                            newsType: NewsType.searchNews,
                            searchKeyword: value,
                          );
                        }));
                      },
                      decoration: textFieldDecoration.copyWith(
                        errorText: errText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        runSpacing: 8,
                        children: categories
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoadingScreen(
                                        searchCategory:
                                            e == "Tech" ? "Technology" : e,
                                        newsType: NewsType.headlinesCategorized,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                      e,
                                      style: kListTileSmallTextStyle,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Populate News fetched as a list
            newsList.isEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Search result: 404 - Data not found in the galaxy. 🌌 Try another query or venture into a new category! 🚀✨",
                        style: kMediumTitleTextStyle.copyWith(
                          color: Colors.black,
                          height: 1.4,
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NewsScreen(
                                  news: widget.newsData["articles"][index],
                                  category: "General",
                                );
                              }));
                            },
                            child: ListContainer(
                              news: widget.newsData["articles"][index],
                            ),
                          );
                        },
                        childCount: newsList.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
