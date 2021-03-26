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
import 'package:tweet_ui/src/retweet.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/twitter_logo.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

class TweetView extends StatelessWidget {
  /// Business logic class created from [TweetVM.fromApiModel]
  final TweetVM _tweetVM;

  /// Style of the user name
  final TextStyle? userNameStyle;

  /// Style of the '@' user name and the date of the Tweet
  final TextStyle? userScreenNameStyle;

  /// Style of the Tweet text
  final TextStyle? textStyle;

  /// Style of the clickable elements in the Tweet text (URLs, mentions, hashtags, symbols)
  final TextStyle? clickableTextStyle;

  /// Style of the retweet information
  final TextStyle? retweetInformationTextStyle;

  /// Style of the user name in a embedded quote Tweet
  final TextStyle? quoteUserNameStyle;

  /// Style of the '@' user name and the date of the Tweet in a embedded quote Tweet
  final TextStyle? quoteUserScreenNameStyle;

  /// Style of the Tweet text in a embedded quote Tweet
  final TextStyle? quoteTextStyle;

  /// Style of the clickable elements in the Tweet text (URLs, mentions, hashtags, symbols) in a embedded quote Tweet
  final TextStyle? quoteClickableTextStyle;

  /// Color of the border around embedded quote Tweet
  final Color? quoteBorderColor;

  /// Color of the embedded quote Tweet background
  final Color? quoteBackgroundColor;

  /// Color of the Tweet background
  final Color? backgroundColor;

  /// If set to true a better_player will be used in a Tweet containing a video.
  /// If set to false a image placeholder will he shown and a video will be played in a new page.
  final bool? useVideoPlayer;

  /// If the Tweet contains a video then an initial volume can be specified with a value between 0.0 and 1.0.
  final double? videoPlayerInitialVolume;

  /// Function used when you want a custom image tapped callback
  final OnTapImage? onTapImage;

  /// Date format when the tweet was created. When null it defaults to DateFormat("HH:mm • MM.dd.yyyy", 'en_US')
  final DateFormat? createdDateDisplayFormat;

  /// If set to true better_player will load the highest quality available.
  /// If set to false better_player will load the lowest quality available.
  final bool? videoHighQuality;

  TweetView(
    this._tweetVM, {
    this.userNameStyle,
    this.userScreenNameStyle,
    this.textStyle,
    this.clickableTextStyle,
    this.retweetInformationTextStyle,
    this.quoteUserNameStyle,
    this.quoteUserScreenNameStyle,
    this.quoteTextStyle,
    this.quoteClickableTextStyle,
    this.quoteBorderColor,
    this.quoteBackgroundColor,
    this.backgroundColor,
    this.useVideoPlayer,
    this.videoPlayerInitialVolume,
    this.onTapImage,
    this.createdDateDisplayFormat,
    this.videoHighQuality,
  }); //  TweetView(this.tweetVM);

  TweetView.fromTweet(
    Tweet tweet, {
    this.userNameStyle = defaultUserNameStyle,
    this.userScreenNameStyle = defaultUserScreenNameStyle,
    this.textStyle = defaultTextStyle,
    this.clickableTextStyle = defaultClickableTextStyle,
    this.retweetInformationTextStyle = defaultRetweetInformationStyle,
    this.quoteUserNameStyle = defaultQuoteUserNameStyle,
    this.quoteUserScreenNameStyle = defaultQuoteUserScreenNameStyle,
    this.quoteTextStyle = defaultQuoteTextStyle,
    this.quoteClickableTextStyle = defaultQuoteClickableTextStyle,
    this.quoteBorderColor = Colors.grey,
    this.quoteBackgroundColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.useVideoPlayer = true,
    this.videoPlayerInitialVolume = 0.0,
    this.onTapImage,
    this.createdDateDisplayFormat,
    this.videoHighQuality = true,
  }) : _tweetVM = TweetVM.fromApiModel(tweet, createdDateDisplayFormat);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: <Widget>[
          MediaContainer(
            _tweetVM,
            ViewMode.standard,
            useVideoPlayer: useVideoPlayer,
            videoPlayerInitialVolume: videoPlayerInitialVolume,
            onTapImage: onTapImage,
            videoHighQuality: videoHighQuality,
          ),
          GestureDetector(
            onTap: () {
              openUrl(_tweetVM.tweetLink);
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      openUrl(_tweetVM.getDisplayTweet().userLink);
                    },
                    child: Stack(
                      children: <Widget>[
                        IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              RetweetInformation(
                                _tweetVM,
                                retweetInformationStyle:
                                    retweetInformationTextStyle,
                              ),
                              Row(
                                children: <Widget>[
                                  ProfileImage(tweetVM: _tweetVM),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Byline(
                                        _tweetVM,
                                        ViewMode.standard,
                                        userNameStyle: userNameStyle,
                                        userScreenNameStyle:
                                            userScreenNameStyle,
                                      ),
                                    ),
                                  ),
                                ],
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
                    openUrl(_tweetVM.tweetLink);
                  },
                  child: TweetText(
                    _tweetVM,
                    textStyle: textStyle,
                    clickableTextStyle: clickableTextStyle,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
                (_tweetVM.quotedTweet != null)
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                        child: QuoteTweetView.fromTweet(
                          _tweetVM.quotedTweet!,
                          textStyle: quoteTextStyle,
                          clickableTextStyle: quoteClickableTextStyle,
                          userNameStyle: quoteUserNameStyle,
                          userScreenNameStyle: quoteUserScreenNameStyle,
                          backgroundColor: quoteBackgroundColor,
                          borderColor: quoteBorderColor,
                          onTapImage: onTapImage,
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
