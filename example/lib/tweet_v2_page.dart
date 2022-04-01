import 'package:example/tweet_page.dart';
import 'package:example/ui/open_tweetpage_button.dart';
import 'package:flutter/material.dart';

class TweetV2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twitter API V2 page'),
      ),
      body: ListView(
        children: [
          OpenTweetPageButton(
            title: "Tweet",
            tweetPath: 'assets/tweet_v2_examples/tweet.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Quote Tweet",
            tweetPath: 'assets/tweet_v2_examples/quote_tweet.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Extended Tweet",
            tweetPath: 'assets/tweet_v2_examples/extended_tweet.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Retweet",
            tweetPath: 'assets/tweet_v2_examples/retweet.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Retweeted Quote Tweet",
            tweetPath: 'assets/tweet_v2_examples/retweeted_quote_tweet.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Tweet Reply",
            tweetPath: 'assets/tweet_v2_examples/tweet_reply.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Tweet With Media",
            tweetPath: 'assets/tweet_v2_examples/tweet_with_media.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Tweet Photos",
            tweetPath: 'assets/tweet_v2_examples/tweet_with_photos.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Tweet with just text",
            tweetPath: 'assets/tweet_v2_examples/tiny_tweet.json',
            tweetType: TweetType.v2,
          ),
          OpenTweetPageButton(
            title: "Single tweet",
            tweetPath: 'assets/tweet_v2_examples/single_tweet.json',
            tweetType: TweetType.v2,
          ),
        ],
      ),
    );
  }
}
