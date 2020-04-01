import 'package:example/embedded_tweet_page.dart';
import 'package:example/tweet_page.dart';
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
          buildButton(
            "1 photo",
            'assets/tweet_examples/tweet_1_photo.json',
            'assets/tweet_examples/tweet_quote_1_photo.json',
            context,
          ),
          buildButton(
            "2 photos",
            'assets/tweet_examples/tweet_2_photos.json',
            'assets/tweet_examples/tweet_quote_2_photos.json',
            context,
          ),
          buildButton(
            "3 photos",
            'assets/tweet_examples/tweet_3_photos.json',
            'assets/tweet_examples/tweet_quote_3_photos.json',
            context,
          ),
          buildButton(
            "4 photos",
            'assets/tweet_examples/tweet_4_photos.json',
            'assets/tweet_examples/tweet_quote_4_photos.json',
            context,
          ),
          buildButton(
            "Video",
            'assets/tweet_examples/tweet_video.json',
            'assets/tweet_examples/tweet_quote_video.json',
            context,
          ),
          buildButton(
            "GIF",
            'assets/tweet_examples/tweet_gif.json',
            'assets/tweet_examples/tweet_quote_gif.json',
            context,
          ),
          buildButton(
            "Bug Github #14",
            'assets/tweet_examples/tweet_bug_gh14.json',
            'assets/tweet_examples/tweet_quote_bug_gh14.json',
            context,
          ),
          buildEmbeddedButton("Embedded", context)
        ],
      ),
    );
  }

  /// Builds a button that opens a [TweetPage]
  Widget buildButton(String title, String tweetPath, String quoteTweetPath, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: RaisedButton(
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

  Widget buildEmbeddedButton(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: RaisedButton(
        child: Text(
          title,
          textAlign: TextAlign.start,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmbeddedTweetPage()));
        },
      ),
    );
  }
}
