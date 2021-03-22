import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.tweetVM,
  }) : super(key: key);

  final TweetVM tweetVM;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 5),
        child: CircleAvatar(
          backgroundImage:
              CachedNetworkImageProvider(tweetVM.getDisplayTweet().profileUrl),
        ));
  }
}
