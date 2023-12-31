import 'package:flutter/material.dart';
import 'package:news_api/utilities/category_text_bubble.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/utilities.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:rflutter_alert/rflutter_alert.dart';

class NewsScreen extends StatelessWidget {
  final dynamic news;
  final String category;

  const NewsScreen({super.key, this.news, required this.category});

  // docs: https://pub.dev/packages/url_launcher
  _launchURL() async {
    // make sure special characters are safe to use for URL
    final Uri url = Uri.parse(Uri.encodeFull(news["url"]));
    // if error throws condition becomes true
    if (!await launcher.launchUrl(url)) {
      throw Exception("Couldn't load URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: containerBubbleDecoration,
                      child: Column(
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
                      onPressed: () {
                        try {
                          _launchURL();
                        } catch (e) {
                          Alert(
                              context: context,
                              title: "URL Load error",
                              desc:
                                  "We apologize, but we couldn't load the news right now. It seems there's an issue on our end. Please give it another shot later.");
                        }
                      },
                      child: const Text("Learn more")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
