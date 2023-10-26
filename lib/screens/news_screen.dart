import 'package:flutter/material.dart';
import 'package:news_api/utilities/category_text_bubble.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/container_bubble.dart';
import 'package:news_api/utilities/utilities.dart';
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
                  color: kPrimaryBackgroundColor,
                  image: DecorationImage(
                      image: NetworkImage(news["image"]),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.topCenter),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryTextBubble(category: category),
                      const SizedBox(
                        height: 10,
                      ),
                      ContainerBubble(
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              news["title"],
                              style: kTitleTextTitle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              localTimeConvert(news["publishedAt"]),
                              style: kSmallTitleTextStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            news["source"]["name"],
                            style: kTitleTextTitle,
                          ),
                        ),
                        Text(
                          news["content"],
                          style: kBodyTextStyle,
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {}, child: const Text("Learn more")),
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
