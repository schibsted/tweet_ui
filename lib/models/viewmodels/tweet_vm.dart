import 'package:intl/intl.dart';
import 'package:tweet_ui/models/api/v1/entieties/entity.dart';
import 'package:tweet_ui/models/api/v1/tweet.dart';
import 'package:tweet_ui/models/api/v2/tweet_v2.dart';
import 'package:tweet_ui/models/viewmodels/converters/tweet_to_tweet_vm_converter.dart';
import 'package:tweet_ui/models/viewmodels/converters/tweet_v2_to_tweet_vm_converter.dart';

class TweetVM {
  final String? createdAt;
  final bool hasSupportedVideo;
  final List<Entity> allEntities;
  final bool hasPhoto;
  final bool hasGif;
  final String tweetLink;
  final String userLink;
  final String text;
  final Runes textRunes;
  final String? profileUrl;
  final List<String> allPhotos;
  final String userName;
  final String userScreenName;
  final TweetVM? quotedTweet;
  final TweetVM? retweetedTweet;
  final bool userVerified;
  final String? videoPlaceholderUrl;
  final Map<String, String> videoUrls;
  final double? videoAspectRatio;
  final int? favoriteCount;
  final int? repliesCount;
  final int? startDisplayText;
  final int? endDisplayText;
  final bool favorited;
  final bool replied;

  const TweetVM({
    required this.createdAt,
    required this.hasSupportedVideo,
    required this.allEntities,
    required this.hasPhoto,
    required this.hasGif,
    required this.tweetLink,
    required this.userLink,
    required this.text,
    required this.textRunes,
    required this.profileUrl,
    required this.allPhotos,
    required this.userName,
    required this.userScreenName,
    this.quotedTweet,
    this.retweetedTweet,
    required this.userVerified,
    this.videoPlaceholderUrl,
    required this.videoUrls,
    this.videoAspectRatio,
    this.favoriteCount,
    this.repliesCount,
    this.startDisplayText,
    this.endDisplayText,
    required this.favorited,
    required this.replied,
  });

  factory TweetVM.fromApiModel(
          TweetV1Response tweet, DateFormat? createdDateDisplayFormat) =>
      TweetToTweetVMConverter(tweet).convert(createdDateDisplayFormat);

  factory TweetVM.fromApiV2Model(
    TweetV2Response tweetResponse,
    DateFormat? createdDateDisplayFormat,
  ) =>
      TweetV2ToTweetVMConverter(tweetResponse)
          .convert(createdDateDisplayFormat);
}

extension ExtendedText on TweetVM {
  TweetVM getDisplayTweet() {
    if (this.retweetedTweet != null) {
      return retweetedTweet!;
    } else {
      return this;
    }
  }
}
