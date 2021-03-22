import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tweet_ui/default_text_styles.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/on_tap_image.dart';
import 'package:tweet_ui/src/byline.dart';
import 'package:tweet_ui/src/media_container.dart';
import 'package:tweet_ui/src/profile_image_embedded.dart';
import 'package:tweet_ui/src/quote_tweet_view_embedded.dart';
import 'package:tweet_ui/src/retweet.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/twitter_logo.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

class EmbeddedTweetView extends StatelessWidget {
  /// Business logic class created from [TweetVM.fromApiModel]
  final TweetVM _tweetVM;

  /// Background color for the container
  final Color? backgroundColor;

  /// If set to true the the text and icons will be light
  final bool darkMode;

  /// If set to true a betterplayer will be used in a Tweet containing a video.
  /// If set to false a image placeholder will he shown and a video will be played in a new page.
  final bool useVideoPlayer;

  /// If the Tweet contains a video then an initial volume can be specified with a value between 0.0 and 1.0.
  final double? videoPlayerInitialVolume;

  /// Function used when you want a custom image tapped callback
  final OnTapImage? onTapImage;

  /// Date format when the tweet was created. When null it defaults to DateFormat("HH:mm • MM.dd.yyyy", 'en_US')
  final DateFormat? createdDateDisplayFormat;

  /// If set to true betterplayer/video_player will load the highest quality available.
  /// If set to false betterplayer/video_player will load the lowest quality available.
  final bool videoHighQuality;

  EmbeddedTweetView(
    this._tweetVM, {
    this.backgroundColor,
    required this.darkMode,
    required this.useVideoPlayer,
    this.videoPlayerInitialVolume,
    this.onTapImage,
    this.createdDateDisplayFormat,
    required this.videoHighQuality,
  }); //  TweetView(this.tweetVM);

  EmbeddedTweetView.fromTweet(
    Tweet tweet, {
    this.backgroundColor = Colors.white,
    this.darkMode = false,
    this.useVideoPlayer = true,
    this.videoPlayerInitialVolume = 0.0,
    this.onTapImage,
    this.createdDateDisplayFormat,
    this.videoHighQuality = true,
  }) : _tweetVM = TweetVM.fromApiModel(tweet, createdDateDisplayFormat);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 0.6, color: Colors.grey[400]!),
        color: backgroundColor,
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              openUrl(_tweetVM.tweetLink);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                Padding(
                                  child: RetweetInformation(
                                    _tweetVM,
                                    retweetInformationStyle:
                                        defaultEmbeddedRetweetInformationStyle,
                                  ),
                                  padding: EdgeInsets.only(left: 28),
                                ),
                                Row(
                                  children: <Widget>[
                                    ProfileImage(tweetVM: _tweetVM),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Byline(
                                          _tweetVM,
                                          ViewMode.standard,
                                          userNameStyle: TextStyle(
                                            color: (darkMode)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16.0,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w700,
                                          ),
                                          showDate: false,
                                          userScreenNameStyle:
                                              defaultEmbeddedUserNameStyle,
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
                      textStyle: (darkMode)
                          ? defaultEmbeddedDarkTextStyle
                          : defaultEmbeddedTextStyle,
                      clickableTextStyle: defaultEmbeddedClickableTextStyle,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                    ),
                  ),
                  (_tweetVM.quotedTweet != null)
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 10),
                          child: QuoteTweetViewEmbed.fromTweet(
                            _tweetVM.quotedTweet!,
                            textStyle: TextStyle(
                                color:
                                    (darkMode) ? Colors.white : Colors.black),
                            clickableTextStyle: defaultQuoteClickableTextStyle,
                            userNameStyle: (darkMode)
                                ? defaultEmbeddedDarkQuoteUserNameStyle
                                : defaultQuoteUserNameStyle,
                            userScreenNameStyle:
                                defaultQuoteUserScreenNameStyle,
                            backgroundColor: null,
                            borderColor: null,
                            onTapImage: onTapImage,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: MediaContainer(
              _tweetVM,
              ViewMode.standard,
              useVideoPlayer: useVideoPlayer,
              videoPlayerInitialVolume: videoPlayerInitialVolume,
              onTapImage: onTapImage,
              videoHighQuality: videoHighQuality,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: Row(
              children: <Widget>[
                Icon(
                  _tweetVM.favorited ? Icons.favorite : Icons.favorite_border,
                  color: (darkMode) ? Colors.grey[400] : Colors.grey[600],
                  size: 18,
                ),
                Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Text(_tweetVM.favoriteCount.toString(),
                        style: TextStyle(
                            color: (darkMode)
                                ? Colors.grey[400]
                                : Colors.grey[600]))),
                Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(_tweetVM.createdAt,
                        style: TextStyle(
                            color: (darkMode)
                                ? Colors.grey[400]
                                : Colors.grey[600])))
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                openUrl(_tweetVM.userLink);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: (darkMode) ? Colors.blue[100] : Colors.blue[700],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "${_tweetVM.userName}'s other tweets",
                        style: TextStyle(
                            color: (darkMode)
                                ? Colors.blue[100]
                                : Colors.blue[800],
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
