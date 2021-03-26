import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/on_tap_image.dart';
import 'package:tweet_ui/src/byline.dart';
import 'package:tweet_ui/src/media_container.dart';
import 'package:tweet_ui/src/tweet_text.dart';
import 'package:tweet_ui/src/url_launcher.dart';
import 'package:tweet_ui/src/view_mode.dart';

typedef onTapImage = void Function(
    List<String> allPhotos, int photoIndex, String hashcode);

class QuoteTweetViewEmbed extends StatelessWidget {
  final TweetVM tweetVM;
  final TextStyle? userNameStyle;
  final TextStyle? userScreenNameStyle;
  final TextStyle? textStyle;
  final TextStyle? clickableTextStyle;
  final Color? borderColor;
  final Color? backgroundColor;
  final OnTapImage? onTapImage;

  QuoteTweetViewEmbed(
    this.tweetVM, {
    this.userNameStyle,
    this.userScreenNameStyle,
    this.textStyle,
    this.clickableTextStyle,
    this.borderColor,
    this.backgroundColor,
    this.onTapImage,
  }); //  TweetView(this.tweetVM);

  QuoteTweetViewEmbed.fromTweet(
    this.tweetVM, {
    this.userNameStyle,
    this.userScreenNameStyle,
    this.textStyle,
    this.clickableTextStyle,
    this.borderColor,
    this.backgroundColor,
    this.onTapImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openUrl(tweetVM.tweetLink);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: new Border.all(
              width: 0.8,
              color: Colors.grey[400]!,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Byline(
                      tweetVM,
                      ViewMode.quote,
                      userNameStyle: userNameStyle,
                      userScreenNameStyle: userScreenNameStyle,
                      showDate: false,
                    ),
                    TweetText(
                      tweetVM,
                      textStyle: textStyle,
                      clickableTextStyle: clickableTextStyle,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                  ],
                ),
              ),
              MediaContainer(
                tweetVM,
                ViewMode.quote,
                useVideoPlayer: false,
                onTapImage: onTapImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
