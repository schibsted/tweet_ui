import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tweet_ui/models/api/v2/entities/media_v2.dart';
import 'package:tweet_ui/models/api/v2/entities/tweet_entities_v2.dart';
import 'package:tweet_ui/models/api/v2/user_v2.dart';

part 'tweet_v2.g.dart';

/// Comparing this model to Twitter API V1, it is important to notice that in V2 most of the fields are optional.
/// The only required fields are id and text. But this package might require some more fields to properly display tweets.
/// Those need to be included in expansion parameters.
@JsonSerializable()
class TweetV2Response {
  /// This field will contain the actual tweet.
  /// One endpoints of twitter API returns here a list an another returns a single object, hence Object
  /// but in reality it should always be either TweetV2 or List<TweetV2>
  /// If response is a list we always take the first element
  final Object data;

  /// This field will contain any objects referenced from tweet inside data field, like media, users or tweets
  final TweetV2Includes includes;

  /// This is the tweet extracted from [data] field
  final TweetV2 tweet;

  TweetV2Response({
    required this.data,
    this.includes = const TweetV2Includes(),
  }) : tweet = _getTweet(data);

  /// This function can accept both JSON that has a list and a single object in [data] field
  /// So both
  /// - {"data": ["created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
  /// - {"data": {"created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
  /// are valid
  factory TweetV2Response.fromRawJson(String str) =>
      TweetV2Response.fromJson(json.decode(str));

  /// This function can accept both JSON that has a list and a single object in [data] field
  /// So both
  /// - {"data": ["created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
  /// - {"data": {"created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
  /// are valid
  factory TweetV2Response.fromJson(Map<String, dynamic> json) =>
      _$TweetV2ResponseFromJson(json);

  /// For the sake of this library we always assume there is exactly one tweet to be displayed
  static TweetV2 _getTweet(Object data) {
    /// If already proper object simply return it
    if (data is TweetV2) {
      return data;
    }

    /// Case for referenced tweets
    if (data is List<TweetV2>) {
      return data.first;
    }

    if (data is List) {
      return TweetV2.fromJson(data.first as Map<String, dynamic>);
    }
    return TweetV2.fromJson(data as Map<String, dynamic>);
  }
}

@JsonSerializable()
class TweetV2 {
  /// The unique identifier of the requested Tweet.
  final String id;

  /// The actual UTF-8 text of the Tweet. See [twitter-text]("https://github.com/twitter/twitter-text/")
  /// for details on what characters are currently considered valid.
  final String text;

  /// The unique identifier of the User who posted this Tweet. The user object could be found by this id inside
  /// TweetV2Response::includes::users
  @JsonKey(name: "author_id")
  final String? authorId;

  /// Entities which have been parsed out of the text of the Tweet.
  final TweetEntitiesV2 entities;

  /// Creation time of the Tweet. In ISO 8601 format
  @JsonKey(name: "created_at")
  final String? createdAt;

  /// A list of Tweets this Tweet refers to.
  /// For example, if the parent Tweet is a Retweet, a Retweet with comment (also known as Quoted Tweet) or a Reply,
  /// it will include the related Tweet referenced to by its parent.
  /// In this field we will only get ids of the tweets. Proper object will be included in TweetV2Response::includes::tweets
  @JsonKey(name: "referenced_tweets")
  final List<ReferencedTweet> referencedTweets;

  /// Specifies the type of attachments (if any) present in this Tweet.
  /// FOr the sake of this package we are only interested in media attachments
  final TweetV2Attachment attachments;

  /// Public engagement metrics for the Tweet at the time of the request.
  @JsonKey(name: "public_metrics")
  final TweetV2PublicMetrics publicMetrics;

  const TweetV2({
    required this.id,
    required this.text,
    this.authorId,
    this.entities = const TweetEntitiesV2.empty(),
    this.createdAt,
    this.referencedTweets = const [],
    this.attachments = const TweetV2Attachment.empty(),
    this.publicMetrics = const TweetV2PublicMetrics.empty(),
  });

  factory TweetV2.fromJson(Map<String, dynamic> json) =>
      _$TweetV2FromJson(json);
}

enum ReferencedTweetType {
  retweeted,
  @JsonValue("replied_to")
  repliedTo,
  quoted
}

@JsonSerializable()
class ReferencedTweet {
  /// Type of the referenced tweet - see [ReferencedTweetType]
  final ReferencedTweetType type;

  /// Id of the referenced tweets that need to be lookup in TweetV2Response::includes::tweets
  final String id;

  const ReferencedTweet(this.type, this.id);

  factory ReferencedTweet.fromJson(Map<String, dynamic> json) =>
      _$ReferencedTweetFromJson(json);
}

@JsonSerializable()
class TweetV2Attachment {
  /// The media keys (ids) for media attached to a tweet. Media could be one of: gif, photo, video.
  final List<String> mediaKeys;

  const TweetV2Attachment({this.mediaKeys = const []});

  const TweetV2Attachment.empty() : this.mediaKeys = const [];

  factory TweetV2Attachment.fromJson(Map<String, dynamic> json) =>
      _$TweetV2AttachmentFromJson(json);
}

@JsonSerializable()
class TweetV2PublicMetrics {
  /// Number of likes (hearts) for given tweet
  @JsonKey(name: "like_count")
  final int likeCount;

  ///Number of replies for given tweet
  @JsonKey(name: "reply_count")
  final int replyCount;

  const TweetV2PublicMetrics({required this.likeCount, this.replyCount = 0});

  const TweetV2PublicMetrics.empty()
      : this.likeCount = 0,
        this.replyCount = 0;

  factory TweetV2PublicMetrics.fromJson(Map<String, dynamic> json) =>
      _$TweetV2PublicMetricsFromJson(json);
}

@JsonSerializable()
class TweetV2Includes {
  /// Tweets referenced from the main tweet from TweetV2Response::data
  final List<TweetV2> tweets;

  /// Users referenced from the main tweet from TweetV2Response::data
  final List<UserV2> users;

  /// Media referenced from the main tweet from TweetV2Response::data
  final List<MediaV2> media;

  const TweetV2Includes({
    this.tweets = const [],
    this.users = const [],
    this.media = const [],
  });

  factory TweetV2Includes.fromJson(Map<String, dynamic> json) =>
      _$TweetV2IncludesFromJson(json);
}
