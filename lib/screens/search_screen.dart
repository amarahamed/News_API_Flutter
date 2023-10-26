import 'package:flutter/material.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/utilities.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  late List<Widget> categoryWidgets;

  @override
  void initState() {
    super.initState();

    categoryWidgets = categories
        .map((e) => GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    e,
                    style: kListTileSmallTextStyle,
                  )),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.transparent,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Find",
                      style: kTitleTextTitle,
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16, top: 8)),
                    TextField(
                      onChanged: (value) {},
                      decoration: textFieldDecoration,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8,
                        runSpacing: 8,
                        children: categoryWidgets,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // TO:DO get general news data from api by going to LoadingScreen
            // Using that data Build ListTitle
            // SliverList(delegate: );
          ],
        ),
      ),
    );
  }
}
