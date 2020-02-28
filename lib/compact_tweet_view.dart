library tweet_ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tweet_ui/default_text_styles.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/on_tap_image.dart';
import 'package:tweet_ui/src/byline.dart';
import 'package:tweet_ui/src/media_container.dart';
import 'package:tweet_ui/src/profile_image.dart';
import 'package:tweet_ui/src/quote_tweet_view.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

class CompactTweetView extends StatelessWidget {
  /// Business logic class created from [TweetVM.fromApiModel]
  final TweetVM _tweetVM;

  /// Style of the user name
  final TextStyle userNameStyle;

  /// Style of the '@' user name and the date of the Tweet
  final TextStyle userScreenNameStyle;

  /// Style of the Tweet text
  final TextStyle textStyle;

  /// Style of the clickable elements in the Tweet text (URLs, mentions, hashtags, symbols)
  final TextStyle clickableTextStyle;

  /// Style of the user name in a embedded quote Tweet
  final TextStyle quoteUserNameStyle;

  /// Style of the '@' user name and the date of the Tweet in a embedded quote Tweet
  final TextStyle quoteUserScreenNameStyle;

  /// Style of the Tweet text in a embedded quote Tweet
  final TextStyle quoteTextStyle;

  /// Style of the clickable elements in the Tweet text (URLs, mentions, hashtags, symbols) in a embedded quote Tweet
  final TextStyle quoteClickableTextStyle;

  /// Color of the border around embedded quote Tweet
  final Color quoteBorderColor;

  /// Color of the embedded quote Tweet background
  final Color quoteBackgroundColor;

  /// Color of the Tweet background
  final Color backgroundColor;

  /// If set to true a chewie/video_player will be used in a Tweet containing a video.
  /// If set to false a image placeholder will he shown and a video will be played in a new page.
  final bool useVideoPlayer;

  /// Function used when you want a custom image tapped callback
  final OnTapImage onTapImage;

  /// Date format when the tweet was created. When null it defaults to DateFormat("HH:mm • MM.dd.yyyy", 'en_US')
  final DateFormat createdDateDisplayFormat;

  CompactTweetView(
    this._tweetVM, {
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
    this.onTapImage,
    this.createdDateDisplayFormat
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
    this.onTapImage,
    this.createdDateDisplayFormat
  }) : _tweetVM = TweetVM.fromApiModel(tweet, createdDateDisplayFormat);

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
            ProfileImage(tweetVM: _tweetVM),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Byline(
                        _tweetVM,
                        ViewMode.compact,
                        userNameStyle: userNameStyle,
                        userScreenNameStyle: userScreenNameStyle,
                      ),
                    ),
                    MediaContainer(
                      _tweetVM,
                      ViewMode.compact,
                      useVideoPlayer: useVideoPlayer,
                      onTapImage: onTapImage,
                    ),
                    GestureDetector(
                      onTap: () {
                        openUrl(_tweetVM.tweetLink);
                      },
                      child: TweetText(
                        _tweetVM,
                        textStyle: textStyle,
                        clickableTextStyle: clickableTextStyle,
                      ),
                    ),
                    (_tweetVM.quotedTweet != null)
                        ? Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: QuoteTweetView.fromTweet(
                              _tweetVM.quotedTweet,
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
