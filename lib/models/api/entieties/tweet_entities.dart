import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/hashtag_entity.dart';
import 'package:tweet_ui/models/api/entieties/media_entity.dart';
import 'package:tweet_ui/models/api/entieties/mention_entity.dart';
import 'package:tweet_ui/models/api/entieties/symbol_entity.dart';
import 'package:tweet_ui/models/api/entieties/url_entity.dart';

/// Provides metadata and additional contextual information about content posted in a tweet.
class TweetEntities {
  /// Represents hashtags which have been parsed out of the Tweet text.
  List<HashtagEntity> hashtags;

  /// Represents symbols, i.e. $cashtags, included in the text of the Tweet.
  List<SymbolEntity> symbols;

  /// Represents other Twitter users mentioned in the text of the Tweet.
  List<MentionEntity> userMentions;

  /// Represents URLs included in the text of a Tweet.
  List<UrlEntity> urls;

  /// Represents media elements uploaded with the Tweet.
  List<MediaEntity> media;

  TweetEntities({
    this.hashtags,
    this.symbols,
    this.userMentions,
    this.urls,
    this.media,
  });

  factory TweetEntities.fromRawJson(String str) =>
      TweetEntities.fromJson(json.decode(str));

  factory TweetEntities.fromJson(Map<String, dynamic> json) =>
      new TweetEntities(
        hashtags: json["hashtags"] == null
            ? null
            : new List<HashtagEntity>.from(
                json["hashtags"].map((x) => HashtagEntity.fromJson(x))),
        symbols: json["symbols"] == null
            ? null
            : new List<SymbolEntity>.from(
                json["symbols"].map((x) => SymbolEntity.fromJson(x))),
        userMentions: json["user_mentions"] == null
            ? null
            : new List<MentionEntity>.from(
                json["user_mentions"].map((x) => MentionEntity.fromJson(x))),
        urls: json["urls"] == null
            ? null
            : new List<UrlEntity>.from(
                json["urls"].map((x) => UrlEntity.fromJson(x))),
        media: json["media"] == null
            ? null
            : new List<MediaEntity>.from(
                json["media"].map((x) => MediaEntity.fromJson(x))),
      );
}
