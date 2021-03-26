import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/hashtag_entity.dart';
import 'package:tweet_ui/models/api/entieties/media_entity.dart';
import 'package:tweet_ui/models/api/entieties/mention_entity.dart';
import 'package:tweet_ui/models/api/entieties/symbol_entity.dart';
import 'package:tweet_ui/models/api/entieties/url_entity.dart';

/// Provides metadata and additional contextual information about content posted in a tweet.
class TweetEntities {
  /// Represents hashtags which have been parsed out of the Tweet text.
  final List<HashtagEntity> hashtags;

  /// Represents symbols, i.e. $cashtags, included in the text of the Tweet.
  final List<SymbolEntity> symbols;

  /// Represents other Twitter users mentioned in the text of the Tweet.
  final List<MentionEntity> userMentions;

  /// Represents URLs included in the text of a Tweet.
  final List<UrlEntity> urls;

  /// Represents media elements uploaded with the Tweet.
  final List<MediaEntity> media;

  TweetEntities({
    required this.hashtags,
    required this.symbols,
    required this.userMentions,
    required this.urls,
    required this.media,
  });

  const TweetEntities.empty()
      : this.hashtags = const [],
        this.symbols = const [],
        this.userMentions = const [],
        this.urls = const [],
        this.media = const [];

  factory TweetEntities.fromRawJson(String str) =>
      TweetEntities.fromJson(json.decode(str));

  factory TweetEntities.fromJson(Map<String, dynamic> json) => TweetEntities(
        hashtags: json["hashtags"] == null
            ? []
            : new List<HashtagEntity>.from(
                json["hashtags"].map((x) => HashtagEntity.fromJson(x))),
        symbols: json["symbols"] == null
            ? []
            : new List<SymbolEntity>.from(
                json["symbols"].map((x) => SymbolEntity.fromJson(x))),
        userMentions: json["user_mentions"] == null
            ? []
            : new List<MentionEntity>.from(
                json["user_mentions"].map((x) => MentionEntity.fromJson(x))),
        urls: json["urls"] == null
            ? []
            : new List<UrlEntity>.from(
                json["urls"].map((x) => UrlEntity.fromJson(x))),
        media: json["media"] == null
            ? []
            : new List<MediaEntity>.from(
                json["media"].map((x) => MediaEntity.fromJson(x))),
      );
}
