import 'package:flutter/material.dart';
import 'package:tweet_ui/default_text_styles.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/src/byline.dart';
import 'package:tweet_ui/src/media_container.dart';
import 'package:tweet_ui/src/profile_image.dart';
import 'package:tweet_ui/src/quote_tweet_view.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/twitter_logo.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

class TweetView extends StatelessWidget {
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

  TweetView(
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

  TweetView.fromTweet(
    Tweet tweet, {
    this.userNameStyle = defaultUserNameStyle,
    this.userScreenNameStyle = defaultUserScreenNameStyle,
    this.textStyle = defaultTextStyle,
    this.clickableTextStyle = defaultClickableTextStyle,
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
      child: Column(
        children: <Widget>[
          MediaContainer(
            tweetVM,
            ViewMode.standard,
            useVideoPlayer: useVideoPlayer,
          ),
          GestureDetector(
            onTap: () {
              openUrl(tweetVM.tweetLink);
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      openUrl(tweetVM.userLink);
                    },
                    child: Stack(
                      children: <Widget>[
                        IntrinsicHeight(
                          child: Row(
                            children: <Widget>[
                              ProfileImage(tweetVM: tweetVM),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Byline(
                                  tweetVM,
                                  ViewMode.standard,
                                  userNameStyle: userNameStyle,
                                  userScreenNameStyle: userScreenNameStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TwitterLogo(),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openUrl(tweetVM.tweetLink);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TweetText(
                      tweetVM,
                      textStyle: textStyle,
                      clickableTextStyle: clickableTextStyle,
                    ),
                  ),
                ),
                (tweetVM.quotedTweet != null)
                    ? Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
        ],
      ),
    );
  }
}
