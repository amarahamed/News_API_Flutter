import 'package:flutter/material.dart';
import 'package:news_api/screens/news_screen.dart';
import 'package:news_api/screens/search_screen.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/container_bubble.dart';
import 'package:news_api/utilities/utilities.dart';
import 'package:news_api/utilities/category_text_bubble.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.newsData});

  final dynamic newsData;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic newsData;

  List headlineList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsData = widget.newsData["articles"];
    headlineList = newsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryBackgroundColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: Colors.black),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryBackgroundColor,
              ),
              child: Text('News API'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              // Headline Section
              Column(
                children: <Widget>[
                  // Headline section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Top Headlines",
                        style: kTitleTextTitle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SearchScreen();
                          }));
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200, // Set the desired height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(newsData[0]
                            ["image"]), // Replace with your image path
                        fit: BoxFit.cover,
                        // You can adjust the fit as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CategoryTextBubble(category: "General"),
                          ContainerBubble(
                              childWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(newsData[0]["source"]["name"],
                                      style: kSmallTitleTextStyle.copyWith(
                                          fontWeight: FontWeight.w500)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text("•",
                                        style: kSmallTitleTextStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                  Text(
                                      localTimeConvert(
                                          newsData[0]["publishedAt"]),
                                      style: kSmallTitleTextStyle),
                                ],
                              ),
                              Text(
                                newsData[0]["title"] ?? "Error Title",
                                style: kMediumTitleTextStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // End of Headline section
              // Title - News
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 22),
                child: Text(
                  "News",
                  style: kTitleTextTitle,
                ),
              ),

              // List of all headlines
              Column(
                children: headlineList
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewsScreen(
                                news: e,
                                category: "General",
                              );
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image(
                                    image: NetworkImage(e["image"]),
                                    width: 118,
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 92,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e["title"],
                                          style: kListTileTitleTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                        Text(
                                          "${e["source"]["name"]}",
                                          style: kListTileSmallTextStyle,
                                        ),
                                        Text(
                                          localTimeConvert(e["publishedAt"]),
                                          style: kListTileSmallTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
