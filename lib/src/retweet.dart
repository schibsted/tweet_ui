import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/src/url_launcher.dart';

/// Widget that displays user name that retweeted a Tweet
class RetweetInformation extends StatelessWidget {
  const RetweetInformation(
    this.tweetVM, {
    Key key,
    this.retweetInformationStyle,
  }) : super(key: key);

  final TweetVM tweetVM;
  final TextStyle retweetInformationStyle;

  @override
  Widget build(BuildContext context) {
    if (tweetVM.retweetedTweet != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          openUrl(tweetVM.userLink);
        },
        child: Padding(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "assets/tw__ic_retweet_light.png",
                      fit: BoxFit.fitWidth,
                      package: 'tweet_ui',
                      color: retweetInformationStyle.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        "Retweeted by ${tweetVM.userName}",
                        overflow: TextOverflow.fade,
                        style: retweetInformationStyle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(bottom: 4.0),
        ),
      );
    } else {
      return Container();
    }
  }
}
