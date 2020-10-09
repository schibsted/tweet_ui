import 'package:example/ui/open_tweetpage_button.dart';
import 'package:flutter/material.dart';

/// Main page of the example app
class BugPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bug page'),
      ),
      body: ListView(
        children: <Widget>[
          OpenTweetPageButton(
            title: "Github #32 1st example",
            tweetPath: 'assets/tweet_examples/tweet_bug_gh32_1st.json',
            quoteTweetPath: null,
          ),
          OpenTweetPageButton(
            title: "Github #32 2nd example",
            tweetPath: 'assets/tweet_examples/tweet_bug_gh32_2nd.json',
            quoteTweetPath: null,
          ),
          OpenTweetPageButton(
            title: "Github #32 3rd example",
            tweetPath: 'assets/tweet_examples/tweet_bug_gh32_3rd.json',
            quoteTweetPath: null,
          ),
          OpenTweetPageButton(
            title: "Bug Github #14",
            tweetPath: 'assets/tweet_examples/tweet_bug_gh14.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_bug_gh14.json',
          ),
          OpenTweetPageButton(
            title: "Bug Github #24",
            tweetPath: 'assets/tweet_examples/tweet_bug_gh24.json',
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_bug_gh24.json',
          ),
          OpenTweetPageButton(
            title: "Retweet, Github #29",
            tweetPath: 'assets/tweet_examples/tweet_retweet.json',
            // retweeted with a commentary from the person who retweeted is a regular quote tweet view
            quoteTweetPath: null,
          ),
          OpenTweetPageButton(
            title: "Favorited, Github #52",
            tweetPath: 'assets/tweet_examples/tweet_favorited_gh52.json',
            // Now favorited value is used in EmbeddedTweetView
            quoteTweetPath: 'assets/tweet_examples/tweet_quote_favorited_gh52.json',
          ),
        ],
      ),
    );
  }
}
