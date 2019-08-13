library tweet_ui;

import 'package:flutter/material.dart';
import 'package:tweet_ui/default_text_styles.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/src/byline.dart';
import 'package:tweet_ui/src/media_container.dart';
import 'package:tweet_ui/src/profile_image.dart';
import 'package:tweet_ui/src/quote_tweet_view.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

class CompactTweetView extends StatelessWidget {
  final TweetVM tweetVM;
  final TextStyle userNameStyle;
  final TextStyle userScreenNameStyle;
  final TextStyle textStyle;
  final TextStyle clickableTextStyle;
  final TextStyle quoteUserNameStyle;
  final TextStyle quoteUserScreenNameStyle;
  final TextStyle quoteTextStyle;
  final TextStyle quoteClickableTextStyle;
  final Color quoteBorderColor;
  final Color quoteBackgroundColor;
  final Color backgroundColor;
  final bool useVideoPlayer;

  CompactTweetView(
    this.tweetVM, {
    this.userNameStyle,
    this.userScreenNameStyle,
    this.textStyle,
    this.clickableTextStyle,
    this.quoteUserNameStyle,
    this.quoteUserScreenNameStyle,
    this.quoteTextStyle,
    this.quoteClickableTextStyle,
    this.quoteBorderColor,
    this.quoteBackgroundColor,
    this.backgroundColor,
    this.useVideoPlayer,
  }); //  TweetView(this.tweetVM);

  CompactTweetView.fromTweet(
    Tweet tweet, {
    this.userNameStyle = defaultCompactUserNameStyle,
    this.userScreenNameStyle = defaultCompactUserScreenNameStyle,
    this.textStyle = defaultCompactTextStyle,
    this.clickableTextStyle = defaultCompactClickableTextStyle,
    this.quoteUserNameStyle = defaultQuoteUserNameStyle,
    this.quoteUserScreenNameStyle = defaultQuoteUserScreenNameStyle,
    this.quoteTextStyle = defaultQuoteTextStyle,
    this.quoteClickableTextStyle = defaultQuoteClickableTextStyle,
    this.quoteBorderColor = Colors.grey,
    this.quoteBackgroundColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.useVideoPlayer = true,
  }) : tweetVM = TweetVM.fromApiModel(tweet);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ProfileImage(tweetVM: tweetVM),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Byline(
                        tweetVM,
                        ViewMode.compact,
                        userNameStyle: userNameStyle,
                        userScreenNameStyle: userScreenNameStyle,
                      ),
                    ),
                    MediaContainer(
                      tweetVM,
                      ViewMode.compact,
                      useVideoPlayer: useVideoPlayer,
                    ),
                    GestureDetector(
                      onTap: () {
                        openUrl(tweetVM.tweetLink);
                      },
                      child: TweetText(
                        tweetVM,
                        textStyle: textStyle,
                        clickableTextStyle: clickableTextStyle,
                      ),
                    ),
                    (tweetVM.quotedTweet != null)
                        ? Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: QuoteTweetView.fromTweet(
                              tweetVM.quotedTweet,
                              textStyle: quoteTextStyle,
                              clickableTextStyle: quoteClickableTextStyle,
                              userNameStyle: quoteUserNameStyle,
                              userScreenNameStyle: quoteUserScreenNameStyle,
                              backgroundColor: quoteBackgroundColor,
                              borderColor: quoteBorderColor,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
