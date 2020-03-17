import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/src/twitter_logo.dart';
import 'package:tweet_ui/src/verified_user_badge.dart';
import 'package:tweet_ui/src/view_mode.dart';

/// Widget that displays user name, user screen name (the @ name), if the user is verified
class BylineQuote extends StatelessWidget {
  const BylineQuote(
    this.tweetVM,
    this.viewMode, {
    Key key,
    this.userNameStyle,
    this.userScreenNameStyle,
  }) : super(key: key);

  final TweetVM tweetVM;
  final TextStyle userNameStyle;
  final TextStyle userScreenNameStyle;
  final ViewMode viewMode;

  @override
  Widget build(BuildContext context) {
    switch (viewMode) {
      case ViewMode.standard:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  tweetVM.userName,
                  textAlign: TextAlign.left,
                  style: userNameStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: VerifiedUsedBadge(tweetVM, viewMode),
                ),
              ],
            ),
            Text(
              "@sssdsd" + tweetVM.userScreenName,
              textAlign: TextAlign.left,
              style: userScreenNameStyle,
            ),
          ],
        );
        break;
      case ViewMode.compact:
      case ViewMode.quote:
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tweetVM.userName,
                    style: userNameStyle,
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: VerifiedUsedBadge(tweetVM, viewMode),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "@" + tweetVM.userScreenName,
                        style: userScreenNameStyle,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            TwitterLogo(),
          ],
        );
      default:
        /// should never happen
        return Container();
    }
  }
}
