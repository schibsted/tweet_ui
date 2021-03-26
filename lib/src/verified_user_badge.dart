import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/src/view_mode.dart';

class VerifiedUsedBadge extends StatelessWidget {
  const VerifiedUsedBadge(
    this.tweetVM,
    this.viewMode, {
    Key? key,
  }) : super(key: key);

  final TweetVM tweetVM;
  final ViewMode viewMode;

  @override
  Widget build(BuildContext context) {
    return (tweetVM.getDisplayTweet().userVerified)
        ? Image.asset(
            "assets/tw__ic_tweet_verified.png",
            fit: BoxFit.fitWidth,
            package: 'tweet_ui',
            height: viewMode != ViewMode.standard ? 14 : 16,
            width: viewMode != ViewMode.standard ? 14 : 16,
          )
        : Container();
  }
}
