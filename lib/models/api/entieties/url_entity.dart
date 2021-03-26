import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents URLs included in the text of a Tweet or within textual fields of a user object.
class UrlEntity extends Entity {
  /// Wrapped URL, corresponding to the value embedded directly into the raw Tweet text, and the values for the indices parameter.
  String url;

  /// Expanded version of `` display_url`` .
  String expandedUrl;

  /// URL pasted/typed into Tweet.
  String displayUrl;

  UrlEntity({
    required this.url,
    required this.expandedUrl,
    required this.displayUrl,
    required indices,
  }) : super(indices: indices);

  factory UrlEntity.fromRawJson(String str) =>
      UrlEntity.fromJson(json.decode(str));

  factory UrlEntity.fromJson(Map<String, dynamic> json) => new UrlEntity(
        url: json["url"] == null ? null : json["url"],
        expandedUrl: json["expanded_url"] == null ? null : json["expanded_url"],
        displayUrl: json["display_url"] == null ? null : json["display_url"],
        indices: json["indices"] == null
            ? null
            : new List<int>.from(json["indices"].map((x) => x)),
      );
}
