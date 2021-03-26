import 'package:flutter/material.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/src/tweet_video.dart';

class AnimatedPlayButton extends StatefulWidget {
  final TweetVM? tweetVM;

  const AnimatedPlayButton({
    Key? key,
    this.tweetVM,
  }) : super(key: key);

  @override
  _AnimatedPlayButtonState createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) {
            return WillPopScope(
              child: TweetVideo(
                widget.tweetVM!.getDisplayTweet(),
                autoPlay: true,
                enableFullscreen: false,
                videoHighQuality: true,
              ),
              onWillPop: () {
                return Future.value(true);
              },
            );
          },
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTap: _onTapDown,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Image.asset(
        "assets/tw__ic_play_default.png",
        fit: BoxFit.fitWidth,
        package: 'tweet_ui',
        height: 50,
        width: 50,
      );
}
