import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:tweet_ui/models/api/v1/entieties/entity.dart';
import 'package:tweet_ui/models/api/v2/entities/media_v2.dart';
import 'package:tweet_ui/models/api/v2/tweet_v2.dart';
import 'package:tweet_ui/models/api/v2/user_v2.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';

class TweetV2ToTweetVMConverter {
  static const String _PHOTO_TYPE = "photo";
  static const String _VIDEO_TYPE = "video";
  static const String _GIF_TYPE = "animated_gif";
  static const String _TWITTER_URL = "https://twitter.com/";
  static const String _UNKNOWN_SCREEN_NAME = "twitter_unknown";

  final TweetV2Response tweetResponse;

  const TweetV2ToTweetVMConverter(this.tweetResponse);

  TweetVM convert(DateFormat? createdDateDisplayFormat) {
    return TweetVM(
      createdAt: _createdAt(createdDateDisplayFormat),
      hasSupportedVideo: _hasSupportedVideo(),
      allEntities: _allEntities(_originalTweetOrRetweet),
      hasPhoto: _hasPhoto(),
      hasGif: _hasGif(),
      tweetLink: _tweetLink()!,
      userLink: _userLink()!,
      text: _text(_originalTweetOrRetweet),
      textRunes: _runes(_originalTweetOrRetweet),
      profileUrl: _profileURL(),
      allPhotos: _allPhotos(),
      userName: _userName(),
      userScreenName: _userScreenName(),
      quotedTweet:
          _quotedTweet(_originalTweetOrRetweet, createdDateDisplayFormat),
      retweetedTweet: _retweetedTweet(createdDateDisplayFormat),
      userVerified: _userVerified(),
      videoPlaceholderUrl: _videoPlaceholderUrl(),
      videoUrls: _videoUrls(),
      videoAspectRatio: _videoAspectRatio(),
      favoriteCount: _favoriteCount,
      repliesCount: _repliesCount,
      startDisplayText: _startDisplayText,
      endDisplayText: _endDisplayText(_originalTweetOrRetweet),
      favorited: _favorited,
      replied: _replied,
    );
  }

  TweetV2 get _originalTweetOrRetweet => _getPossibleRetweetedTweet() ?? tweet;

  TweetV2 get tweet => tweetResponse.tweet;

  String? _createdAt(DateFormat? displayFormat) {
    if (tweet.createdAt == null) {
      return null;
    }

    final dateTime = DateTime.parse(tweet.createdAt!);
    return (displayFormat ?? DateFormat("HH:mm • MM.dd.yyyy", 'en_US'))
        .format(dateTime);
  }

  bool _isPhotoType(MediaV2 mediaEntity) => _PHOTO_TYPE == mediaEntity.type;

  bool _isVideoType(MediaV2 mediaEntity) =>
      _VIDEO_TYPE == mediaEntity.type || _GIF_TYPE == mediaEntity.type;

  bool _isGifType(MediaV2 mediaEntity) => _GIF_TYPE == mediaEntity.type;

  bool _hasSupportedVideo() => _videoEntity() != null;

  MediaV2? _videoEntity() {
    try {
      return _allMediaEntities()
          .firstWhere((MediaV2 mediaEntity) => _isVideoType(mediaEntity));
    } catch (e) {
      return null;
    }
  }

  List<MediaV2> _allMediaEntities() => tweetResponse.includes.media;

  List<Entity> _allEntities(TweetV2 tweet) {
    final List<Entity> allEntities = [
      ...tweet.entities.hashtags.map((e) => e.toV1()).toList(),
      ...tweet.entities.cashtags.map((e) => e.toV1()).toList(),
      ...tweet.entities.urls.map((e) => e.toV1()).toList(),
      ...tweet.entities.mentions.map((e) => e.toV1()).toList(),
    ];
    allEntities.sort((a, b) => a.start.compareTo(b.start));

    return allEntities;
  }

  MediaV2? _photoEntity() {
    final List<MediaV2> mediaEntityList = _allMediaEntities();
    for (int i = mediaEntityList.length - 1; i >= 0; i--) {
      final MediaV2 entity = mediaEntityList[i];
      if (_isPhotoType(entity)) {
        return entity;
      }
    }
    return null;
  }

  MediaV2? _gifEntity() {
    final List<MediaV2> mediaEntityList = _allMediaEntities();
    for (int i = mediaEntityList.length - 1; i >= 0; i--) {
      final MediaV2 entity = mediaEntityList[i];
      if (_isGifType(entity)) {
        return entity;
      }
    }
    return null;
  }

  bool _hasPhoto() => _photoEntity() != null;

  bool _hasGif() => _gifEntity() != null;

  UserV2? tweetAuthor() {
    final authorId = tweet.authorId;
    return tweetResponse.includes.users
        .firstWhereOrNull((user) => user.id == authorId);
  }

  String? _tweetLink() {
    if (tweetAuthor()?.username.isEmpty ?? true) {
      return "$_TWITTER_URL$_UNKNOWN_SCREEN_NAME/status/${tweet.id}";
    } else {
      return "$_TWITTER_URL${tweetAuthor()!.username}/status/${tweet.id}";
    }
  }

  String? _userLink() {
    if (tweetAuthor()?.username.isEmpty ?? true) {
      return "$_TWITTER_URL$_UNKNOWN_SCREEN_NAME";
    } else {
      return "$_TWITTER_URL${tweetAuthor()!.username}";
    }
  }

  String _text(TweetV2 tweet) => tweet.text;

  Runes _runes(TweetV2 tweet) => tweet.text.runes;

  String? _profileURL() => tweetAuthor()?.profileImageUrl;

  List<String> _allPhotos() {
    return tweetResponse.includes.media
        .where((MediaV2 mediaEntity) =>
            _isPhotoType(mediaEntity) && mediaEntity.url != null)
        .map((MediaV2 mediaEntity) =>
            mediaEntity.url ?? mediaEntity.previewImageUrl ?? "")
        .where((url) => url.isNotEmpty)
        .toList(growable: false);
  }

  String _userName() => tweetAuthor()?.name ?? "";

  String _userScreenName() => tweetAuthor()?.username ?? "";

  TweetVM? _quotedTweet(TweetV2 tweet, DateFormat? createdDateDisplayFormat) {
    final String? quotedTweetId = tweet.referencedTweets
        .firstWhereOrNull((tweet) => tweet.type == ReferencedTweetType.quoted)
        ?.id;

    final TweetV2? quotedTweet = tweetResponse.includes.tweets
        .firstWhereOrNull((tweet) => tweet.id == quotedTweetId);

    if (quotedTweet == null) {
      return null;
    }

    return TweetV2ToTweetVMConverter(TweetV2Response(
      data: [quotedTweet],
      includes: tweetResponse.includes,
    )).convert(createdDateDisplayFormat);
  }

  TweetV2? _getPossibleRetweetedTweet() {
    final String? retweetedTweetId = tweet.referencedTweets
        .firstWhereOrNull(
            (tweet) => tweet.type == ReferencedTweetType.retweeted)
        ?.id;

    return tweetResponse.includes.tweets
        .firstWhereOrNull((tweet) => tweet.id == retweetedTweetId);
  }

  TweetVM? _retweetedTweet(DateFormat? createdDateDisplayFormat) {
    final TweetV2? retweetedTweet = _getPossibleRetweetedTweet();

    if (retweetedTweet == null) {
      return null;
    }

    return TweetV2ToTweetVMConverter(TweetV2Response(
      data: [retweetedTweet],
      includes: tweetResponse.includes,
    )).convert(createdDateDisplayFormat);
  }

  bool _userVerified() => tweetAuthor()?.verified ?? false;

  String? _videoPlaceholderUrl() => _videoEntity()?.previewImageUrl;

  Map<String, String> _videoUrls() => {"Default": _videoEntity()?.url ?? ""};

  double? _videoAspectRatio() {
    final videoEntity = _videoEntity();

    if (videoEntity == null ||
        videoEntity.width == null ||
        videoEntity.height == null) {
      return null;
    }

    return videoEntity.width! / videoEntity.height!;
  }

  int get _favoriteCount => tweet.publicMetrics.likeCount;

  int get _repliesCount => tweet.publicMetrics.replyCount;

  int get _startDisplayText => 0;

  int _endDisplayText(TweetV2 tweet) => tweet.text.length;

  bool get _favorited => _favoriteCount > 0;

  bool get _replied => _repliesCount > 0;
}
