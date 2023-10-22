import 'package:flutter/material.dart';
import 'package:news_api/utilities/category_text_bubble.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  dynamic news;
  String category;

  NewsScreen({super.key, this.news, required this.category});

  // launch url
  Future<void> launchURL() async {
    // parse
    final Uri url = Uri.parse(news["url"]);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // throw Exception("Could not launch URL");
      print("Couldn't launch url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage(news["image"]),
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter),
                ),
                child: Column(
                  children: [
                    CategoryTextBubble(category: category),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Text(news["content"]),
                    TextButton(
                        onPressed: () {},
                        child: const Text("For more click here")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
