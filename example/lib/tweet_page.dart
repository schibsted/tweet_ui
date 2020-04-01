import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

/// Widget containing 4 Tweet types:
/// TweetView, CompactTweetView, TweetView with a quoted Tweet, CompactTweetView with a quoted Tweet
class TweetPage extends StatelessWidget {
  /// The AppBar title and prefix for the header title
  final String mediaType;

  /// The path to a Tweet JSON file
  final String tweetPath;

  /// The path to a Tweet with a embedded quote JSON file
  final String quoteTweetPath;

  const TweetPage(
    this.mediaType,
    this.tweetPath,
    this.quoteTweetPath, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(mediaType),
      ),
      body: ListView(
        children: <Widget>[
          buildHeader("$mediaType TweetEmbed"),
          buildTweetEmbed(tweetPath),
          buildHeader("$mediaType Quote TweetEmbed"),
          buildTweetEmbed(quoteTweetPath),
          buildHeader("$mediaType TweetView"),
          buildTweet(tweetPath),
          buildHeader("$mediaType CompactTweetView"),
          buildCompactTweetView(tweetPath),
          buildHeader("$mediaType Quote TweetView"),
          buildTweet(quoteTweetPath),
          buildHeader("$mediaType Quote CompactTweetView"),
          buildCompactTweetView(quoteTweetPath),
        ],
      ),
    );
  }

  /// Builds a header for a TweetView
  Widget buildHeader(String headerTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Text(
        headerTitle,
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }

  /// Builds a TweetView from a JSON file
  Widget buildTweetEmbed(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.all(15),
            child: TweetEmbed.fromTweet(
              Tweet.fromRawJson(
                snapshot.data,
              ),
              darkMode: false,
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

  /// Builds a TweetView from a JSON file
  Widget buildTweet(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return TweetView.fromTweet(
            Tweet.fromRawJson(
              snapshot.data,
            ),
            createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
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

  /// Builds a CompactTweetView from a JSON file
  Widget buildCompactTweetView(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CompactTweetView.fromTweet(
            Tweet.fromRawJson(
              snapshot.data,
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
