// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetV2Response _$TweetV2ResponseFromJson(Map<String, dynamic> json) =>
    TweetV2Response(
      data: json['data'] as Object,
      includes: json['includes'] == null
          ? const TweetV2Includes()
          : TweetV2Includes.fromJson(json['includes'] as Map<String, dynamic>),
    );

TweetV2 _$TweetV2FromJson(Map<String, dynamic> json) => TweetV2(
      id: json['id'] as String,
      text: json['text'] as String,
      authorId: json['author_id'] as String?,
      entities: json['entities'] == null
          ? const TweetEntitiesV2.empty()
          : TweetEntitiesV2.fromJson(json['entities'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      referencedTweets: (json['referenced_tweets'] as List<dynamic>?)
              ?.map((e) => ReferencedTweet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      attachments: json['attachments'] == null
          ? const TweetV2Attachment.empty()
          : TweetV2Attachment.fromJson(
              json['attachments'] as Map<String, dynamic>),
      publicMetrics: json['public_metrics'] == null
          ? const TweetV2PublicMetrics.empty()
          : TweetV2PublicMetrics.fromJson(
              json['public_metrics'] as Map<String, dynamic>),
    );

ReferencedTweet _$ReferencedTweetFromJson(Map<String, dynamic> json) =>
    ReferencedTweet(
      $enumDecode(_$ReferencedTweetTypeEnumMap, json['type']),
      json['id'] as String,
    );

const _$ReferencedTweetTypeEnumMap = {
  ReferencedTweetType.retweeted: 'retweeted',
  ReferencedTweetType.repliedTo: 'replied_to',
  ReferencedTweetType.quoted: 'quoted',
};

TweetV2Attachment _$TweetV2AttachmentFromJson(Map<String, dynamic> json) =>
    TweetV2Attachment(
      mediaKeys: (json['mediaKeys'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

TweetV2PublicMetrics _$TweetV2PublicMetricsFromJson(
        Map<String, dynamic> json) =>
    TweetV2PublicMetrics(
      likeCount: json['like_count'] as int,
      replyCount: json['reply_count'] as int? ?? 0,
    );

TweetV2Includes _$TweetV2IncludesFromJson(Map<String, dynamic> json) =>
    TweetV2Includes(
      tweets: (json['tweets'] as List<dynamic>?)
              ?.map((e) => TweetV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => UserV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => MediaV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
