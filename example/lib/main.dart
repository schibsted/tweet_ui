import 'package:example/bug_page.dart';
import 'package:example/embedded_tweet_page.dart';
import 'package:example/ui/open_tweetpage_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TweetUiExample()));

/// Main page of the example app
class TweetUiExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet UI Example'),
      ),
      body: ListView(
        children: <Widget>[
          OpenTweetPageButton(
            title: "1 photo",
            tweetPath: 'assets/tweet_examples/tweet_1_photo.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_1_photo.json',
          ),
          OpenTweetPageButton(
            title: "2 photos",
            tweetPath: 'assets/tweet_examples/tweet_2_photos.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_2_photos.json',
          ),
          OpenTweetPageButton(
            title: "3 photos",
            tweetPath: 'assets/tweet_examples/tweet_3_photos.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_3_photos.json',
          ),
          OpenTweetPageButton(
            title: "4 photos",
            tweetPath: 'assets/tweet_examples/tweet_4_photos.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_4_photos.json',
          ),
          OpenTweetPageButton(
            title: "Video",
            tweetPath: 'assets/tweet_examples/tweet_video.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_video.json',
          ),
          OpenTweetPageButton(
            title: "GIF",
            tweetPath: 'assets/tweet_examples/tweet_gif.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_gif.json',
          ),
          buildOpenEmbeddedTweetPageButton("Embedded", context),
          buildOpenBugPageButton("Bug page", context),
        ],
      ),
    );
  }

  Widget buildOpenEmbeddedTweetPageButton(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: ElevatedButton(
        child: Text(
          title,
          textAlign: TextAlign.start,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EmbeddedTweetPage()));
        },
      ),
    );
  }

  Widget buildOpenBugPageButton(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: ElevatedButton(
        child: Text(
          title,
          textAlign: TextAlign.start,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BugPage()));
        },
      ),
    );
  }
}
