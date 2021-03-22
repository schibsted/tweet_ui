import 'package:example/tweet_page.dart';
import 'package:flutter/material.dart';

/// Builds a button that opens a [TweetPage]

class OpenTweetPageButton extends StatelessWidget {
  final String title;
  final String tweetPath;
  final String? quoteTweetPath;

  const OpenTweetPageButton(
      {Key? key, required this.title, required this.tweetPath, this.quoteTweetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: ElevatedButton(
        child: Text(
          title,
          textAlign: TextAlign.start,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TweetPage(
                title,
                tweetPath,
                quoteTweetPath,
              ),
            ),
          );
        },
      ),
    );
  }
}
