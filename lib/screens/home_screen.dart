import 'package:flutter/material.dart';
import 'package:news_api/utilities/constants.dart';
// format date time
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.newsData});

  final dynamic newsData;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic newsData;

  List<Widget> headlineList = [];
  List hhh = [];

  void updateUI() {}

  /*
  * title: Text(x["title"]),
        leading: Image.network(x["image"]),
        trailing: Text("${x["source"]["name"]} • ${x["publishedAt"]}"),
  * */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsData = widget.newsData["articles"];
    hhh = newsData;
    localTimeConvert(newsData[0]["publishedAt"]);
    // add headlines to the list
    // headlineList
    // for (var x in newsData) {
    //   headlineList.add(Row(
    //     children: [
    //       Image(
    //         image: NetworkImage(x["image"]),
    //         width: 100,
    //         height: 100,
    //         fit: BoxFit.fill,
    //       ),
    //       Column(
    //         children: [
    //           Text(x["title"]),
    //           Text("${x["source"]["name"]} • ${x["publishedAt"]}"),
    //         ],
    //       ),
    //     ],
    //   ));
    // }
  }

  String localTimeConvert(String utcTime) {
    DateTime utc = DateTime.parse(utcTime);

    return "${DateFormat('MMMM').format(utc)}-${utc.day}-${utc.year}";
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
                        onPressed: () {},
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5555FF).withAlpha(200),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "General",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black26,
                            ),
                            child: Column(
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
                                ),
                              ],
                            ),
                          ),
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
                children: hhh
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image: NetworkImage(e["image"]),
                                  width: 108,
                                  height: 92,
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e["title"],
                                    ),
                                    Text(
                                      "${e["source"]["name"]} • ${e["publishedAt"]}",
                                      style: kSmallTitleTextStyle.copyWith(
                                          color: Colors.black),
                                    ), // Text(
                                    //   "${e["source"]["name"]} • ${e["publishedAt"]}",
                                    //   style: kSmallTitleTextStyle,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
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
