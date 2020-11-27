import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:video_player/video_player.dart';

class TweetVideo extends StatefulWidget {
  TweetVideo(
    this.tweetVM, {
    Key key,
    this.initialVolume = 0.0,
    this.autoPlay = false,
    this.enableFullscreen = true,
    this.videoHighQuality = true,
  }) : super(key: key);

  final TweetVM tweetVM;
  final double initialVolume;
  final bool autoPlay;
  final bool enableFullscreen;
  final bool videoHighQuality;

  @override
  _TweetVideoState createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController controller;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    final videoUrl = widget.videoHighQuality
        ? widget.tweetVM.getDisplayTweet().videoUrls.values.last
        : widget.tweetVM.getDisplayTweet().videoUrls.values.first;
    controller = VideoPlayerController.network(videoUrl);
    controller.setVolume(widget.initialVolume);

    chewieController = ChewieController(
      videoPlayerController: controller,
      aspectRatio: widget.tweetVM.getDisplayTweet().videoAspectRatio,
      showControls: !widget.tweetVM.getDisplayTweet().hasGif,
      allowedScreenSleep: false,
      allowFullScreen: widget.enableFullscreen,
      fullScreenByDefault: false,
      autoInitialize: true,
      allowMuting: !widget.tweetVM.getDisplayTweet().hasGif,
      autoPlay: widget.tweetVM.getDisplayTweet().hasGif || widget.autoPlay,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: widget.tweetVM.getDisplayTweet().videoAspectRatio,
      child: Chewie(
        controller: chewieController,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
