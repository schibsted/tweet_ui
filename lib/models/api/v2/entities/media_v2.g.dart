// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaV2 _$MediaV2FromJson(Map<String, dynamic> json) => MediaV2(
      mediaKey: json['media_key'] as String,
      type: json['type'] as String,
      url: json['url'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      durationMilliseconds: (json['duration_ms'] as num?)?.toDouble(),
      previewImageUrl: json['preview_image_url'] as String?,
    );
