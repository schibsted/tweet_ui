import 'package:flutter/material.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/api/user.dart';
import 'package:tweet_ui/tweet_ui.dart';

class TweetPageBugGH50 extends StatefulWidget {
  @override
  _TweetPageBugGH50State createState() => _TweetPageBugGH50State();
}

class _TweetPageBugGH50State extends State<TweetPageBugGH50> {
  @override
  Widget build(BuildContext context) {
    final user = User(
        id: 121,
        name: "Marshal Sarit",
        screenName: "King Prayed",
        verified: true,
        profileImageUrlHttps:
            "https://d1ab2zufs7bob.cloudfront.net/media/avatars/avatar_GlDoZ0w.jpg");
    final tweet = Tweet(
      createdAt: "Wed Oct 10 20:19:24 +0000 2018",
      id: 1050118621198921728,
      idStr: "1050118621198921728",
      text:
          "To make room for more expression, we will now count all emojis as equal—including those with gender‍‍‍ ‍‍and skin t… https://t.co/MkGjXf9aXm",
      favoriteCount: 22,
      favorited: false,
      user: user,
    );
    return Scaffold(
      body: Column(
        children: [
          TweetView.fromTweet(tweet),
          CompactTweetView.fromTweet(tweet),
          EmbeddedTweetView.fromTweet(tweet),
        ],
      ),
    );
  }
}
