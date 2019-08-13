import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

class TweetPage extends StatelessWidget {
  final String mediaType;
  final String tweetPath;
  final String quoteTweetPath;
  final bool useVideoPlayer;

  const TweetPage(
    this.mediaType,
    this.tweetPath,
    this.quoteTweetPath, {
    Key key,
    this.useVideoPlayer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediaType),
      ),
      body: ListView(
        children: <Widget>[
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

  Widget buildHeader(String headerTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        headerTitle,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildTweet(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return TweetView.fromTweet(
            Tweet.fromRawJson(
              snapshot.data,
            ),
            useVideoPlayer: useVideoPlayer,
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

  Widget buildCompactTweetView(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CompactTweetView.fromTweet(
            Tweet.fromRawJson(
              snapshot.data,
            ),
            useVideoPlayer: useVideoPlayer,
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
