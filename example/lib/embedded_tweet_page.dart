import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

/// Widget containing 4 Tweet types:
/// TweetView, CompactTweetView, TweetView with a quoted Tweet, CompactTweetView with a quoted Tweet
class EmbeddedTweetPage extends StatefulWidget {
  const EmbeddedTweetPage({
    Key? key,
  }) : super(key: key);

  @override
  _EmbeddedTweetPageState createState() => _EmbeddedTweetPageState();
}

class _EmbeddedTweetPageState extends State<EmbeddedTweetPage> {
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (darkMode) ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: Text("Embedded Tweets"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          padding: EdgeInsets.only(top: 15),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              color: (darkMode) ? Colors.grey[800] : Colors.white,
              child: ListTile(
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                      color: (darkMode) ? Colors.white : Colors.black),
                ),
                trailing: Switch(
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                    }),
              ),
            ),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_1_photo.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_quote_1_photo.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_2_photos.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_quote_2_photos.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_3_photos.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_quote_3_photos.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_4_photos.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_quote_4_photos.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_video.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_quote_video.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_gif.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_quote_gif.json", darkMode),
            buildEmbeddedTweetView(
                "assets/tweet_examples/tweet_retweet.json", darkMode),
          ],
        ),
      ),
    );
  }

  /// Builds a header for a TweetView
  Widget buildHeader(String headerTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        headerTitle,
        textAlign: TextAlign.start,
      ),
    );
  }

  /// Builds a TweetView from a JSON file
  Widget buildEmbeddedTweetView(String jsonFile, bool darkMode) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: EmbeddedTweetView.fromTweet(
              Tweet.fromRawJson(
                snapshot.data,
              ),
              backgroundColor: (darkMode) ? Colors.grey[800]! : Colors.white,
              darkMode: darkMode,
              createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
            ),
          );
        }
        if (snapshot.hasError) {
          return Container(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
