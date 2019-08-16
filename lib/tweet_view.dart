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

typedef onTapImage = void Function(List<String> allPhotos, int photoIndex, String hashcode);

class TweetView extends StatelessWidget {
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
  final Function onTapImage;

  TweetView(
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
    this.onTapImage
  }) : _tweetVM = TweetVM.fromApiModel(tweet);

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
            onTapImage: onTapImage
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
                    openUrl(_tweetVM.tweetLink);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TweetText(
                      _tweetVM,
                      textStyle: textStyle,
                      clickableTextStyle: clickableTextStyle,
                    ),
                  ),
                ),
                (_tweetVM.quotedTweet != null)
                    ? Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
        ],
      ),
    );
  }
}
