import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:tweet_ui/tweet_ui.dart';

enum TweetType { v1, v2 }

/// Widget containing 4 Tweet types:
/// TweetView, CompactTweetView, TweetView with a quoted Tweet, CompactTweetView with a quoted Tweet
class TweetPage extends StatelessWidget {
  /// The AppBar title and prefix for the header title
  final String mediaType;

  /// The path to a Tweet JSON file
  final String tweetPath;

  /// The path to a Tweet with a embedded quote JSON file
  final String? quoteTweetPath;

  final TweetType tweetType;

  const TweetPage(
    this.mediaType,
    this.tweetPath,
    this.quoteTweetPath, {
    this.tweetType = TweetType.v1,
    Key? key,
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
          buildHeader("$mediaType EmbeddedTweetView"),
          buildEmbeddedTweetView(tweetPath),
          if (quoteTweetPath != null)
            buildHeader("$mediaType Quote EmbeddedTweetView"),
          if (quoteTweetPath != null) buildEmbeddedTweetView(quoteTweetPath!),
          buildHeader("$mediaType TweetView"),
          buildTweet(tweetPath),
          buildHeader("$mediaType CompactTweetView"),
          buildCompactTweetView(tweetPath),
          if (quoteTweetPath != null) buildHeader("$mediaType Quote TweetView"),
          if (quoteTweetPath != null) buildTweet(quoteTweetPath!),
          if (quoteTweetPath != null)
            buildHeader("$mediaType Quote CompactTweetView"),
          if (quoteTweetPath != null) buildCompactTweetView(quoteTweetPath!),
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
  Widget buildEmbeddedTweetView(String jsonFile) {
    return FutureBuilder(
      future: rootBundle.loadString(jsonFile),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.all(15),
            child: _buildEmbeddedTweetFromSnapshot(snapshot),
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
          return _buildTweetFromSnapshot(snapshot);
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
          return _buildCompactTweetFromSnapshot(snapshot);
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

  Widget _buildEmbeddedTweetFromSnapshot(AsyncSnapshot snapshot) {
    switch (tweetType) {
      case TweetType.v1:
        return EmbeddedTweetView.fromTweetV1(
          TweetV1Response.fromRawJson(
            snapshot.data,
          ),
          darkMode: false,
          createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
          showRepliesCount: true,
        );
      case TweetType.v2:
        return EmbeddedTweetView.fromTweetV2(
          TweetV2Response.fromRawJson(
            snapshot.data,
          ),
          darkMode: false,
          createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
          showRepliesCount: true,
        );
    }
  }

  Widget _buildTweetFromSnapshot(AsyncSnapshot snapshot) {
    switch (tweetType) {
      case TweetType.v1:
        return TweetView.fromTweetV1(
          TweetV1Response.fromRawJson(
            snapshot.data,
          ),
          createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
        );
      case TweetType.v2:
        return TweetView.fromTweetV2(
          TweetV2Response.fromRawJson(
            snapshot.data,
          ),
          createdDateDisplayFormat: DateFormat("EEE, MMM d, ''yy"),
        );
    }
  }

  Widget _buildCompactTweetFromSnapshot(AsyncSnapshot snapshot) {
    switch (tweetType) {
      case TweetType.v1:
        return CompactTweetView.fromTweetV1(
          TweetV1Response.fromRawJson(
            snapshot.data,
          ),
        );
      case TweetType.v2:
        return CompactTweetView.fromTweetV2(
          TweetV2Response.fromRawJson(
            snapshot.data,
          ),
        );
    }
  }
}
