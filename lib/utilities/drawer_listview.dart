import 'package:flutter/material.dart';
import 'package:news_api/screens/loading_screen.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/utilities.dart';

class DrawerListView extends StatelessWidget {
  const DrawerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoadingScreen(newsType: NewsType.headlines);
            }));
          },
        ),
        ListTile(
          title: const Text('Headlines'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoadingScreen(
                newsType: NewsType.headlinesCategorized,
                searchCategory: "general",
              );
            }));
          },
        ),
        ListTile(
          title: const Text('Search'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoadingScreen(
                newsType: NewsType.searchNews,
                searchKeyword: "everything",
              );
            }));
          },
        ),
      ],
    );
  }
}
