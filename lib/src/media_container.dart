import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';
import 'package:tweet_ui/on_tap_image.dart';
import 'package:tweet_ui/src/animated_play_button.dart';
import 'package:tweet_ui/src/tweet_video.dart';
import 'package:tweet_ui/src/view_mode.dart';

/// Widget that displays media resources from a Tweet
class MediaContainer extends StatefulWidget {
  static const double SQUARE_ASPECT_RATIO = 1.0;
  static const double DEFAULT_ASPECT_RATIO_MEDIA_CONTAINER = 3.0 / 2.0;
  final OnTapImage? onTapImage;

  const MediaContainer(
    this.tweetVM,
    this.viewMode, {
    Key? key,
    this.useVideoPlayer = true,
    this.videoPlayerInitialVolume = 0.0,
    this.videoHighQuality = true,
    this.onTapImage,
  }) : super(key: key);

  final TweetVM tweetVM;
  final ViewMode viewMode;
  final bool? useVideoPlayer;
  final bool? videoHighQuality;
  final double? videoPlayerInitialVolume;

  @override
  _MediaContainerState createState() => _MediaContainerState();
}

class _MediaContainerState extends State<MediaContainer>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late var hashcode;

  @override
  void initState() {
    hashcode = this.hashCode.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget? child;
    if (widget.tweetVM.getDisplayTweet().hasSupportedVideo) {
      if (widget.useVideoPlayer!) {
        child = TweetVideo(
          widget.tweetVM.getDisplayTweet(),
          initialVolume: widget.videoPlayerInitialVolume,
          videoHighQuality: widget.videoHighQuality,
        );
      } else {
        child = Stack(
          children: <Widget>[
            Image(
              image: CachedNetworkImageProvider(
                  widget.tweetVM.getDisplayTweet().videoPlaceholderUrl!),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Padding(
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
            ),
            Positioned.fill(
              child: Center(
                child: AnimatedPlayButton(
                  tweetVM: widget.tweetVM.getDisplayTweet(),
                ),
              ),
            )
          ],
        );
      }
    } else if (widget.tweetVM.getDisplayTweet().hasPhoto) {
      switch (widget.tweetVM.getDisplayTweet().allPhotos.length) {
        case 1:
          child = AspectRatio(
            aspectRatio: MediaContainer.DEFAULT_ASPECT_RATIO_MEDIA_CONTAINER,
            child: _buildSinglePhoto(context,
                widget.tweetVM.getDisplayTweet().allPhotos, 0, hashcode),
          );
          break;
        case 2:
          child = AspectRatio(
            aspectRatio: MediaContainer.DEFAULT_ASPECT_RATIO_MEDIA_CONTAINER,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _buildSinglePhoto(context,
                      widget.tweetVM.getDisplayTweet().allPhotos, 0, hashcode),
                ),
                VerticalDivider(color: Colors.white, width: 1.0),
                Expanded(
                  child: _buildSinglePhoto(context,
                      widget.tweetVM.getDisplayTweet().allPhotos, 1, hashcode),
                )
              ],
            ),
          );
          break;
        case 3:
          child = AspectRatio(
            aspectRatio: MediaContainer.DEFAULT_ASPECT_RATIO_MEDIA_CONTAINER,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildSinglePhoto(context,
                      widget.tweetVM.getDisplayTweet().allPhotos, 0, hashcode),
                ),
                VerticalDivider(color: Colors.white, width: 1.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: _buildSinglePhoto(
                            context,
                            widget.tweetVM.getDisplayTweet().allPhotos,
                            1,
                            hashcode),
                      ),
                      Divider(color: Colors.white, height: 1.0),
                      Expanded(
                        child: _buildSinglePhoto(
                            context,
                            widget.tweetVM.getDisplayTweet().allPhotos,
                            2,
                            hashcode),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
          break;
        case 4:
          child = AspectRatio(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: widget.viewMode == ViewMode.standard
                    ? MediaContainer.SQUARE_ASPECT_RATIO
                    : MediaContainer.DEFAULT_ASPECT_RATIO_MEDIA_CONTAINER,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _buildSinglePhoto(
                    context,
                    widget.tweetVM.getDisplayTweet().allPhotos,
                    index,
                    hashcode);
              },
            ),
            aspectRatio: widget.viewMode == ViewMode.standard
                ? MediaContainer.SQUARE_ASPECT_RATIO
                : MediaContainer.DEFAULT_ASPECT_RATIO_MEDIA_CONTAINER,
          );
          break;
        default:
          return Container(width: 0.0, height: 0.0);
      }
    }
    BorderRadius borderRadius;
    switch (widget.viewMode) {
      case ViewMode.compact:
        if (!widget.tweetVM.getDisplayTweet().hasSupportedVideo) {
          borderRadius = BorderRadius.all(Radius.circular(8.0));
        } else {
          borderRadius = BorderRadius.all(Radius.zero);
        }
        break;
      case ViewMode.standard:
      case ViewMode.quote:
      default:
        borderRadius = BorderRadius.all(Radius.zero);
        break;
    }

    if (child == null) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.only(
          top: widget.viewMode == ViewMode.compact ? 8.0 : 0.0,
          bottom: widget.viewMode != ViewMode.quote ? 8.0 : 0.0,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: child,
        ),
      );
    }
  }

  /// allPhotos - list on URLs that is used to build a gallery view
  /// hashcode - used for the Hero tag. The image URL is not enough - for example, you can still have duplicated tweets on a list.
  Widget _buildSinglePhoto(BuildContext context, List<String> allPhotos,
      int photoIndex, String hashcode) {
    final List<PhotoViewGalleryPageOptions> galleryPageOptions = allPhotos
        .map((photoUrl) => PhotoViewGalleryPageOptions(
              // TODO add option to choose image size (Twitter supports ":medium" ":large" at the end of photoUrl.
              imageProvider: CachedNetworkImageProvider(photoUrl),
              heroAttributes: PhotoViewHeroAttributes(
                tag: photoUrl + hashcode,
              ),
            ))
        .toList(growable: false);
    return GestureDetector(
      onTap: this.widget.onTapImage == null
          ? () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return PhotoViewGallery(
                    pageOptions: galleryPageOptions,
                    pageController: PageController(initialPage: photoIndex),
                  );
                },
              ));
            }
          : () => this.widget.onTapImage!(allPhotos, photoIndex, hashcode),
      child: Hero(
        child: Image(
          image: CachedNetworkImageProvider(allPhotos[photoIndex]),
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        tag: allPhotos[photoIndex] + hashcode,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
