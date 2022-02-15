import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tweet_ui/models/api/v1/entieties/tweet_entities.dart';
import 'package:tweet_ui/models/api/v2/entities/cashtag_entity_v2.dart';
import 'package:tweet_ui/models/api/v2/entities/hashtag_entity_v2.dart';
import 'package:tweet_ui/models/api/v2/entities/mention_entity_v2.dart';
import 'package:tweet_ui/models/api/v2/entities/url_entity_v2.dart';

part 'tweet_entities_v2.g.dart';

/// Provides metadata and additional contextual information about content posted in a tweet.
@JsonSerializable()
class TweetEntitiesV2 {
  /// Represents hashtags which have been parsed out of the Tweet text.
  final List<HashtagEntityV2> hashtags;

  /// Represents $cashtags, included in the text of the Tweet.
  final List<CashtagEntityV2> cashtags;

  /// Represents other Twitter users mentioned in the text of the Tweet.
  final List<MentionEntityV2> mentions;

  /// Represents URLs included in the text of a Tweet.
  final List<UrlEntityV2> urls;

  const TweetEntitiesV2({
    this.hashtags = const [],
    this.cashtags = const [],
    this.mentions = const [],
    this.urls = const [],
  });

  const TweetEntitiesV2.empty()
      : this.hashtags = const [],
        this.cashtags = const [],
        this.mentions = const [],
        this.urls = const [];

  factory TweetEntitiesV2.fromRawJson(String str) =>
      TweetEntitiesV2.fromJson(json.decode(str));

  factory TweetEntitiesV2.fromJson(Map<String, dynamic> json) =>
      _$TweetEntitiesV2FromJson(json);

  TweetEntities toV1() => TweetEntities(
        hashtags: hashtags.map((e) => e.toV1()).toList(),
        symbols: cashtags.map((e) => e.toV1()).toList(),
        userMentions: mentions.map((e) => e.toV1()).toList(),
        urls: urls.map((e) => e.toV1()).toList(),

        /// In twitter API V2 media is no longer entity. It is now treated as attachment
        media: [],
      );
}
