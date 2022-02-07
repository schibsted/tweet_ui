import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'media_v2.g.dart';

/// Represents media elements uploaded with the Tweet.
/// In twitter API V2 media is no longer treated as entity, but as attachment.
///
/// Media refers to any image, GIF, or video attached to a Tweet.
/// The media object is not a primary object on any endpoint, but can be found and expanded in the Tweet object.
///
/// The object is available for expansion with [?expansions=attachments.media_keys] to get the condensed object with only default fields.
/// Use the expansion with the field parameter: [media.fields] when requesting additional fields to complete the object.
@JsonSerializable()
class MediaV2 {
  /// The key (id) of the media. It is used to find a proper media object in TweetV2Response::includes::media list
  @JsonKey(name: "media_key")
  final String mediaKey;

  /// Type of the media content. Possible types include photo, video, and animated_gif
  final String type;

  /// Url of the content
  /// This field is not directly listed in Twitter API reference, but seems like can be attached to the actual response
  /// When provided it is used, otherwise [previewImageUrl] will be used to fetch content.
  final String? url;

  /// Height of this content in pixels.
  final int? height;

  /// Width of this content in pixels.
  final int? width;

  /// Available when type is video. Duration in milliseconds of the video.
  @JsonKey(name: "duration_ms")
  final double? durationMilliseconds;

  /// URL to the static placeholder preview of this content.
  @JsonKey(name: "preview_image_url")
  final String? previewImageUrl;

  const MediaV2({
    required this.mediaKey,
    required this.type,
    this.url,
    this.height,
    this.width,
    this.durationMilliseconds,
    this.previewImageUrl,
  });

  factory MediaV2.fromRawJson(String str) => MediaV2.fromJson(json.decode(str));

  factory MediaV2.fromJson(Map<String, dynamic> json) =>
      _$MediaV2FromJson(json);
}
