import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tweet_ui/models/api/v1/entieties/mention_entity.dart';
import 'package:tweet_ui/models/api/v2/entities/entity_v2.dart';

part 'mention_entity_v2.g.dart';

/// Represents other Twitter users mentioned in the text of the Tweet.
@JsonSerializable()
class MentionEntityV2 extends EntityV2 {
  /// Username of the referenced user.
  final String username;

  const MentionEntityV2({
    required this.username,
    required int start,
    required int end,
  }) : super(start: start, end: end);

  factory MentionEntityV2.fromRawJson(String str) =>
      MentionEntityV2.fromJson(json.decode(str));

  factory MentionEntityV2.fromJson(Map<String, dynamic> json) =>
      _$MentionEntityV2FromJson(json);

  MentionEntity toV1() =>
      MentionEntity(screenName: username, indices: [start, end]);
}
