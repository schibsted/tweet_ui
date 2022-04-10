import 'dart:convert';

import 'package:tweet_ui/models/api/v1/entieties/tweet_entities.dart';
import 'package:tweet_ui/models/api/v1/user.dart';

/// docs are from https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/tweet-object
/// Tweets are the basic atomic building block of all things Twitter. Tweets are also known as “status updates.”
/// The Tweet object has a long list of ‘root-level’ attributes, including fundamental attributes such as id, created_at, and text.
/// Tweet objects are also the ‘parent’ object to several child objects. Tweet child objects include user, entities, and extended_entities. Tweets that are
/// geo-tagged will have a place child object.
///
/// To parse this JSON data, do:
/// final tweet = tweetFromJson(jsonString);
class TweetV1Response {
  /// UTC time when this Tweet was created.
  String createdAt;

  /// The integer representation of the unique identifier for this Tweet. This number is greater
  /// than 53 bits and some programming languages may have difficulty/silent defects in
  /// interpreting it. Using a signed 64 bit integer for storing this identifier is safe. Use
  /// id_str for fetching the identifier to stay on the safe side. See Twitter IDs, JSON andSnowflake.
  double id;

  /// The string representation of the unique identifier for this Tweet. Implementations should use
  /// this rather than the large integer in id
  String idStr;

  /// This field only surfaces when the Tweet is a quote Tweet.
  /// This attribute contains the Tweet object of the original Tweet that was quoted.
  TweetV1Response? quotedStatus;

  /// Users can amplify the broadcast of Tweets authored by other users by retweeting.
  /// Retweets can be distinguished from typical Tweets by the existence of a retweeted_status attribute.
  /// This attribute contains a representation of the original Tweet that was retweeted.
  /// Note that retweets of retweets do not show representations of the intermediary retweet, but only the original Tweet.
  /// (Users can also unretweet a retweet they created by deleting their retweet.)
  TweetV1Response? retweetedStatus;

  /// The actual UTF-8 text of the status update. See twitter-text for details on what is currently
  /// considered valid characters.
  String text;

  /// Entities which have been parsed out of the text of the Tweet.
  TweetEntities entities;

  /// Additional entities such as multi photos, animated gifs and video.
  TweetEntities extendedEntities;

  /// The user who posted this Tweet. Perspectival attributes embedded within this object are
  /// unreliable. See Why are embedded objects stale or inaccurate?.
  User user;

  /// Indicates whether this is a Quoted Tweet.
  bool isQuoteStatus;

  /// Nullable. Perspectival. Indicates whether this Tweet has been favorited by the authenticating
  /// user.
  bool? favorited;

  /// The number of favorites(hearts)
  int? favoriteCount;

  /// Nullable. Perspectival. Indicates whether this Tweet has been replied by to
  bool? replied;

  /// The number of replies
  int? replyCount;

  /// Nullable. List of two unicode code point indices, identifying the inclusive start and exclusive end of the displayable content of the Tweet.
  List<int>? displayTextRange;

  TweetV1Response({
    required this.createdAt,
    required this.id,
    required this.idStr,
    this.quotedStatus,
    this.retweetedStatus,
    required this.text,
    this.entities = const TweetEntities.empty(),
    this.extendedEntities = const TweetEntities.empty(),
    required this.user,
    this.isQuoteStatus = false,
    this.favorited,
    this.favoriteCount,
    this.replied,
    this.replyCount,
    this.displayTextRange,
  });

  factory TweetV1Response.fromRawJson(String str) =>
      TweetV1Response.fromJson(json.decode(str));

  factory TweetV1Response.fromJson(Map<String, dynamic> json) =>
      new TweetV1Response(
        createdAt: json["created_at"] == null ? null : json["created_at"],
        id: json["id"] == null ? null : json["id"].toDouble(),
        idStr: json["id_str"] == null ? null : json["id_str"],
        quotedStatus: json["quoted_status"] == null
            ? null
            : TweetV1Response.fromJson(json["quoted_status"]),
        retweetedStatus: json["retweeted_status"] == null
            ? null
            : TweetV1Response.fromJson(json["retweeted_status"]),
        text: json["text"] == null
            ? (json["full_text"] == null ? null : json["full_text"])
            : json["text"],
        entities: json["entities"] == null
            ? const TweetEntities.empty()
            : TweetEntities.fromJson(json["entities"]),
        extendedEntities: json["extended_entities"] == null
            ? const TweetEntities.empty()
            : TweetEntities.fromJson(json["extended_entities"]),
        user: User.fromJson(json["user"]),
        isQuoteStatus:
            json["is_quote_status"] == null ? null : json["is_quote_status"],
        favorited: json["favorited"] == null ? null : json["favorited"],
        favoriteCount:
            json['favorite_count'] == null ? null : json["favorite_count"],
        replied: json["replied"] == null ? null : json["replied"],
        replyCount: json["reply_count"] == null ? null : json["reply_count"],
        displayTextRange: json["display_text_range"] == null
            ? null
            : (json["display_text_range"]).cast<int>(),
      );
}
