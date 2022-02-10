import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tweet_ui/models/api/v1/entieties/hashtag_entity.dart';
import 'package:tweet_ui/models/api/v2/entities/entity_v2.dart';

part 'hashtag_entity_v2.g.dart';

/// Represents hashtags which have been parsed out of the Tweet text.
@JsonSerializable()
class HashtagEntityV2 extends EntityV2 {
  /// Value of the hashtag, without hashtag symbol
  final String tag;

  const HashtagEntityV2({
    required this.tag,
    required int start,
    required int end,
  }) : super(start: start, end: end);

  factory HashtagEntityV2.fromRawJson(String str) =>
      HashtagEntityV2.fromJson(json.decode(str));

  factory HashtagEntityV2.fromJson(Map<String, dynamic> json) =>
      _$HashtagEntityV2FromJson(json);

  HashtagEntity toV1() => HashtagEntity(text: tag, indices: [start, end]);
}
