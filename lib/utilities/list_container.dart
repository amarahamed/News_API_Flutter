import 'package:flutter/material.dart';
import 'package:news_api/utilities/constants.dart';
import 'package:news_api/utilities/utilities.dart';

class ListContainer extends StatelessWidget {
  final dynamic news;

  const ListContainer({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: NetworkImage(news["image"]),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    news["title"],
                    style: kListTileTitleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Text(
                    "${news["source"]["name"]}",
                    style: kListTileSmallTextStyle,
                  ),
                  Text(
                    localTimeConvert(news["publishedAt"]),
                    style: kListTileSmallTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
