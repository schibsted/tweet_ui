import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tweet_ui/default_text_styles_embedded.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/on_tap_image.dart';
import 'package:tweet_ui/src/byline.dart';
import 'package:tweet_ui/src/media_container.dart';
import 'package:tweet_ui/src/profile_image_embedded.dart';
import 'package:tweet_ui/src/quote_tweet_view_embedded.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/twitter_logo_embedded.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

class TweetEmbed extends StatelessWidget {
  /// Business logic class created from [TweetVM.fromApiModel]
  final TweetVM _tweetVM;
  // Background color for the container
  final Color backgroundColor;

  // If set to true the the text and icons will be light
  final bool darkMode;

  /// If set to true a chewie/video_player will be used in a Tweet containing a video.
  /// If set to false a image placeholder will he shown and a video will be played in a new page.
  final bool useVideoPlayer;

  /// Function used when you want a custom image tapped callback
  final OnTapImage onTapImage;

  /// Date format when the tweet was created. When null it defaults to DateFormat("HH:mm • MM.dd.yyyy", 'en_US')
  final DateFormat createdDateDisplayFormat;

  TweetEmbed(
    this._tweetVM, {
    this.backgroundColor,
    this.darkMode,
    this.useVideoPlayer,
    this.onTapImage,
    this.createdDateDisplayFormat,
  }); //  TweetView(this.tweetVM);

  TweetEmbed.fromTweet(Tweet tweet,
      {this.backgroundColor = Colors.white,
      this.darkMode = false,
      this.useVideoPlayer = true,
      this.onTapImage,
      this.createdDateDisplayFormat})
      : _tweetVM = TweetVM.fromApiModel(tweet, createdDateDisplayFormat);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 0.6, color: Colors.grey[400]),
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
                        openUrl(_tweetVM.userLink);
                      },
                      child: Stack(
                        children: <Widget>[
                          IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                ProfileImage(tweetVM: _tweetVM),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Byline(
                                    _tweetVM,
                                    ViewMode.standard,
                                    userNameStyle: TextStyle(
                                      color: (darkMode) ? Colors.white : Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    showDate: false,
                                    userScreenNameStyle: defaultUserScreenNameStyle,
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
                      openUrl(_tweetVM.tweetLink);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                      child: TweetText(
                        _tweetVM,
                        textStyle: (darkMode) ? defaultDarkTextStyle : defaultTextStyle,
                        clickableTextStyle: defaultClickableTextStyle,
                      ),
                    ),
                  ),
                  (_tweetVM.quotedTweet != null)
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 10),
                          child: QuoteTweetViewEmbed.fromTweet(
                            _tweetVM.quotedTweet,
                            textStyle: TextStyle(color: (darkMode) ? Colors.white : Colors.black),
                            clickableTextStyle: defaultQuoteClickableTextStyle,
                            userNameStyle: (darkMode)
                                ? defaultDarkQuoteUserNameStyle
                                : defaultQuoteUserNameStyle,
                            userScreenNameStyle: defaultQuoteUserScreenNameStyle,
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
              onTapImage: onTapImage,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.favorite_border,
                  color: (darkMode) ? Colors.grey[400] : Colors.grey[600],
                  size: 18,
                ),
                Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Text(_tweetVM.favoriteCount.toString(),
                        style: TextStyle(color: (darkMode) ? Colors.grey[400] : Colors.grey[600]))),
                Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(_tweetVM.createdAt,
                        style: TextStyle(color: (darkMode) ? Colors.grey[400] : Colors.grey[600])))
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(
                  Icons.person_outline,
                  color: (darkMode) ? Colors.blue[100] : Colors.blue[700],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "${_tweetVM.userName}'s other tweets",
                    style: TextStyle(
                        color: (darkMode) ? Colors.blue[100] : Colors.blue[800],
                        fontWeight: FontWeight.w400),
                  ),
                )
              ]))
        ],
      ),
    );
  }
}
