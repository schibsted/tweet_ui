import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tweet_ui/models/api/v1/entieties/url_entity.dart';
import 'package:tweet_ui/models/api/v2/entities/entity_v2.dart';

part 'url_entity_v2.g.dart';

/// Represents URLs included in the text of a Tweet or within textual fields of a user object.
@JsonSerializable()
class UrlEntityV2 extends EntityV2 {
  /// Wrapped URL, corresponding to the value embedded directly into the raw Tweet text, and the values for the start/end parameter.
  final String url;

  /// Expanded version of `` display_url`` .
  @JsonKey(name: "expanded_url")
  final String expandedUrl;

  /// URL pasted/typed into Tweet.
  @JsonKey(name: "display_url")
  final String displayUrl;

  const UrlEntityV2({
    required this.url,
    required this.expandedUrl,
    required this.displayUrl,
    required int start,
    required int end,
  }) : super(start: start, end: end);

  factory UrlEntityV2.fromRawJson(String str) =>
      UrlEntityV2.fromJson(json.decode(str));

  factory UrlEntityV2.fromJson(Map<String, dynamic> json) =>
      _$UrlEntityV2FromJson(json);

  UrlEntity toV1() => UrlEntity(
      url: url,
      expandedUrl: expandedUrl,
      displayUrl: displayUrl,
      indices: [start, end]);
}
