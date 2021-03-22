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
    return CachedNetworkImage(
      height: 40,
      width: 40,
      imageUrl: tweetVM.getDisplayTweet().profileUrl,
      placeholder: (context, url) => Container(height: 40, width: 40),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
