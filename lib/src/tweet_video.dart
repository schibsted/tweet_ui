import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:video_player/video_player.dart';

class TweetVideo extends StatefulWidget {
  TweetVideo(
    this.tweetVM, {
    Key? key,
    this.initialVolume = 0.0,
    this.autoPlay = false,
    this.enableFullscreen = true,
    this.videoHighQuality = true,
  }) : super(key: key);

  final TweetVM tweetVM;
  final double? initialVolume;
  final bool autoPlay;
  final bool enableFullscreen;
  final bool? videoHighQuality;

  @override
  _TweetVideoState createState() => _TweetVideoState();
}

class _TweetVideoState extends State<TweetVideo> with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    var videoUrl = widget.videoHighQuality!
        ? widget.tweetVM.getDisplayTweet().videoUrls.values.last
        : widget.tweetVM.getDisplayTweet().videoUrls.values.first;

    _videoPlayerController = VideoPlayerController.network(videoUrl);

    // TODO:
    // - No quality controls
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: widget.tweetVM.getDisplayTweet().hasGif || widget.autoPlay,
      looping: widget.tweetVM.getDisplayTweet().hasGif,
      allowFullScreen: widget.enableFullscreen,
      autoInitialize: true,
      aspectRatio: widget.tweetVM.getDisplayTweet().videoAspectRatio!,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      fullScreenByDefault: false,
      allowedScreenSleep: false,
      allowMuting: !widget.tweetVM.getDisplayTweet().hasGif,
      showControls: !widget.tweetVM.getDisplayTweet().hasGif,
      allowPlaybackSpeedChanging: false,
      errorBuilder: (context, message) {
        return Text('Error while loading video :-(');
      },
      placeholder: Center(
        child: SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(),
        ),
      ),
      overlay: Padding(
        padding: const EdgeInsets.only(
          left: 4.0,
        ),
        child: widget.tweetVM.getDisplayTweet().hasGif
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  "assets/tw__ic_gif_badge.png",
                  fit: BoxFit.fitWidth,
                  package: 'tweet_ui',
                  height: 16,
                  width: 16,
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
