import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents other Twitter users mentioned in the text of the Tweet.
class MentionEntity extends Entity {
  /// Screen name of the referenced user.
  String screenName;

  MentionEntity({
    required this.screenName,
    required indices,
  }) : super(indices: indices);

  factory MentionEntity.fromRawJson(String str) =>
      MentionEntity.fromJson(json.decode(str));

  factory MentionEntity.fromJson(Map<String, dynamic> json) =>
      new MentionEntity(
        screenName: json["screen_name"] == null ? null : json["screen_name"],
        indices: json["indices"] == null
            ? null
            : new List<int>.from(json["indices"].map((x) => x)),
      );
}
