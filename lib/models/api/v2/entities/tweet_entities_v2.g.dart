// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet_entities_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetEntitiesV2 _$TweetEntitiesV2FromJson(Map<String, dynamic> json) =>
    TweetEntitiesV2(
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => HashtagEntityV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cashtags: (json['cashtags'] as List<dynamic>?)
              ?.map((e) => CashtagEntityV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mentions: (json['mentions'] as List<dynamic>?)
              ?.map((e) => MentionEntityV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      urls: (json['urls'] as List<dynamic>?)
              ?.map((e) => UrlEntityV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
