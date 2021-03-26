import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/url_entity.dart';

/// Represents media elements uploaded with the Tweet.
class MediaEntity extends UrlEntity {
  /// ID of the media expressed as a 64-bit integer.
  double id;

  /// An https:// URL pointing directly to the uploaded media file, for embedding on https pages.
  /// For media in direct messages, media_url_https must be accessed by signing a request with the user’s access token using OAuth 1.0A.
  /// It is not possible to access images via an authenticated twitter.com session.
  /// Please visit this page to learn how to account for these recent change.
  /// You cannot directly embed these images in a web page.
  /// See Photo Media URL formatting for how to format a photo's URL, such as media_url_https, based on the available sizes.
  String mediaUrlHttps;

  /// Type of uploaded media. Possible types include photo, video, and animated_gif.
  String type;

  /// An object showing available sizes for the media file.
  Sizes? sizes;

  /// Contains information about video.
  VideoInfo? videoInfo;

  MediaEntity({
    required this.id,
    required this.mediaUrlHttps,
    required url,
    required displayUrl,
    required expandedUrl,
    required this.type,
    this.sizes,
    this.videoInfo,
    required indices,
  }) : super(
            url: url,
            displayUrl: displayUrl,
            expandedUrl: expandedUrl,
            indices: indices);

  factory MediaEntity.fromRawJson(String str) =>
      MediaEntity.fromJson(json.decode(str));

  factory MediaEntity.fromJson(Map<String, dynamic> json) => new MediaEntity(
        id: json["id"] == null ? null : json["id"].toDouble(),
        mediaUrlHttps:
            json["media_url_https"] == null ? null : json["media_url_https"],
        url: json["url"] == null ? null : json["url"],
        displayUrl: json["display_url"] == null ? null : json["display_url"],
        expandedUrl: json["expanded_url"] == null ? null : json["expanded_url"],
        type: json["type"] == null ? null : json["type"],
        sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
        videoInfo: json["video_info"] == null
            ? null
            : VideoInfo.fromJson(json["video_info"]),
        indices: json["indices"] == null
            ? null
            : new List<int>.from(json["indices"].map((x) => x)),
      );
}

/// All Tweets with native media (photos, video, and GIFs) will include a set of ‘thumb’, ‘small’, ‘medium’, and ‘large’ sizes with height and width pixel sizes.
/// For photos and preview image media URLs, Photo Media URL formatting specifies how to construct different URLs for loading different sized photo media.
class Sizes {
  /// Information for a thumbnail-sized version of the media.
  /// Thumbnail-sized photo media will be limited to fill a 150x150 boundary and cropped.
  Size? thumb;

  /// Information for a small-sized version of the media.
  /// Small-sized photo media will be limited to fit within a 680x680 boundary.
  Size? small;

  /// Information for a medium-sized version of the media.
  /// Medium-sized photo media will be limited to fit within a 1200x1200 boundary.
  Size? medium;

  /// Information for a large-sized version of the media.
  /// Large-sized photo media will be limited to fit within a 2048x2048 boundary.
  Size? large;

  Sizes({
    this.thumb,
    this.small,
    this.large,
    this.medium,
  });

  factory Sizes.fromRawJson(String str) => Sizes.fromJson(json.decode(str));

  factory Sizes.fromJson(Map<String, dynamic> json) => new Sizes(
        thumb: json["thumb"] == null ? null : Size.fromJson(json["thumb"]),
        small: json["small"] == null ? null : Size.fromJson(json["small"]),
        large: json["large"] == null ? null : Size.fromJson(json["large"]),
        medium: json["medium"] == null ? null : Size.fromJson(json["medium"]),
      );
}

class Size {
  /// Width in pixels of this size.
  int w;

  /// Height in pixels of this size.
  int h;

  /// Resizing method used to obtain this size.
  /// A value of fit means that the media was resized to fit one dimension, keeping its native aspect ratio.
  /// A value of crop means that the media was cropped in order to fit a specific resolution.
  String resize;

  Size({
    required this.w,
    required this.h,
    required this.resize,
  });

  factory Size.fromRawJson(String str) => Size.fromJson(json.decode(str));

  factory Size.fromJson(Map<String, dynamic> json) => new Size(
        w: json["w"] == null ? null : json["w"],
        h: json["h"] == null ? null : json["h"],
        resize: json["resize"] == null ? null : json["resize"],
      );
}

/// Contains information about video.
class VideoInfo {
  /// The aspect ratio of the video, as a simplified fraction of width and height in a 2-element
  /// list. Typical values are [4, 3] or [16, 9].
  List<int> aspectRatio;

  /// The length of the video, in milliseconds.
  int? durationMillis;

  /// Different encodings/streams of the video.
  List<Variant> variants;

  VideoInfo({
    required this.aspectRatio,
    this.durationMillis,
    required this.variants,
  });

  factory VideoInfo.fromRawJson(String str) =>
      VideoInfo.fromJson(json.decode(str));

  factory VideoInfo.fromJson(Map<String, dynamic> json) => new VideoInfo(
        aspectRatio: json["aspect_ratio"] == null
            ? []
            : new List<int>.from(json["aspect_ratio"].map((x) => x)),
        durationMillis:
            json["duration_millis"] == null ? null : json["duration_millis"],
        variants: json["variants"] == null
            ? []
            : new List<Variant>.from(
                json["variants"].map((x) => Variant.fromJson(x))),
      );
}

class Variant {
  int bitrate;
  String contentType;
  String url;

  Variant({
    required this.bitrate,
    required this.contentType,
    required this.url,
  });

  factory Variant.fromRawJson(String str) => Variant.fromJson(json.decode(str));

  factory Variant.fromJson(Map<String, dynamic> json) => new Variant(
        bitrate: json["bitrate"] == null ? 0 : json["bitrate"],
        contentType: json["content_type"] == null ? null : json["content_type"],
        url: json["url"] == null ? null : json["url"],
      );
}
