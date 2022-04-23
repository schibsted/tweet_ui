import 'package:intl/intl.dart';
import 'package:tweet_ui/models/api/v1/entieties/entity.dart';
import 'package:tweet_ui/models/api/v1/entieties/media_entity.dart';
import 'package:tweet_ui/models/api/v1/tweet.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';

class TweetToTweetVMConverter {
  static const String _PHOTO_TYPE = "photo";
  static const String _VIDEO_TYPE = "video";
  static const String _GIF_TYPE = "animated_gif";
  static const String _TWITTER_URL = "https://twitter.com/";
  static const String _UNKNOWN_SCREEN_NAME = "twitter_unknown";

  final TweetV1Response tweet;

  const TweetToTweetVMConverter(this.tweet);

  TweetVM convert(DateFormat? createdDateDisplayFormat) {
    return TweetVM(
      createdAt: _createdAt(tweet, createdDateDisplayFormat),
      hasSupportedVideo: _hasSupportedVideo(_originalTweetOrRetweet(tweet)),
      allEntities: _allEntities(_originalTweetOrRetweet(tweet)),
      hasPhoto: _hasPhoto(_originalTweetOrRetweet(tweet)),
      hasGif: _hasGif(_originalTweetOrRetweet(tweet)),
      tweetLink: _tweetLink(tweet)!,
      userLink: _userLink(tweet)!,
      text: _text(_originalTweetOrRetweet(tweet)),
      textRunes: _runes(_originalTweetOrRetweet(tweet)),
      profileUrl: _profileURL(tweet),
      allPhotos: _allPhotos(_originalTweetOrRetweet(tweet)),
      userName: _userName(tweet),
      userScreenName: _userScreenName(tweet),
      quotedTweet: _quotedTweet(_originalTweetOrRetweet(tweet).quotedStatus,
          createdDateDisplayFormat),
      retweetedTweet:
          _retweetedTweet(tweet.retweetedStatus, createdDateDisplayFormat),
      userVerified: _userVerified(tweet),
      videoPlaceholderUrl: _videoPlaceholderUrl(_originalTweetOrRetweet(tweet)),
      videoUrls: _videoUrls(_originalTweetOrRetweet(tweet)),
      videoAspectRatio: _videoAspectRatio(_originalTweetOrRetweet(tweet)),
      favoriteCount: _favoriteCount(tweet),
      repliesCount: _repliesCount(tweet),
      startDisplayText: _startDisplayText(_originalTweetOrRetweet(tweet)),
      endDisplayText: _endDisplayText(_originalTweetOrRetweet(tweet)),
      favorited: _favorited(tweet),
      replied: _replied(tweet),
    );
  }

  static TweetV1Response _originalTweetOrRetweet(tweet) {
    return tweet.retweetedStatus != null ? tweet.retweetedStatus : tweet;
  }

  static String _createdAt(TweetV1Response tweet, DateFormat? displayFormat) {
    DateFormat twitterFormat =
        new DateFormat("EEE MMM dd HH:mm:ss '+0000' yyyy", 'en_US');
    final dateTime = twitterFormat.parseUTC(tweet.createdAt).toLocal();
    return (displayFormat ?? new DateFormat("HH:mm • MM.dd.yyyy", 'en_US'))
        .format(dateTime);
  }

  static bool _isPhotoType(MediaEntity mediaEntity) {
    return _PHOTO_TYPE == mediaEntity.type;
  }

  static bool _isVideoType(MediaEntity mediaEntity) {
    return _VIDEO_TYPE == mediaEntity.type || _GIF_TYPE == mediaEntity.type;
  }

  static bool _isGifType(MediaEntity mediaEntity) {
    return _GIF_TYPE == mediaEntity.type;
  }

  static bool _hasSupportedVideo(TweetV1Response tweet) {
    final MediaEntity? entity = _videoEntity(tweet);
    return entity != null;
  }

  static MediaEntity? _videoEntity(TweetV1Response tweet) {
    try {
      return _allMediaEntities(tweet).firstWhere(
        (MediaEntity mediaEntity) => _isVideoType(mediaEntity),
      );
    } catch (e) {
      return null;
    }
  }

  static List<MediaEntity> _allMediaEntities(TweetV1Response tweet) {
    return tweet.entities.media + tweet.extendedEntities.media;
  }

  static List<Entity> _allEntities(TweetV1Response tweet) {
    final List<Entity> allEntities = [
      ...tweet.entities.media,
      ...tweet.entities.hashtags,
      ...tweet.entities.symbols,
      ...tweet.entities.urls,
      ...tweet.entities.userMentions,
    ];
    allEntities.sort((a, b) => a.start.compareTo(b.start));
    return allEntities;
  }

  static MediaEntity? _photoEntity(TweetV1Response tweet) {
    final List<MediaEntity> mediaEntityList = _allMediaEntities(tweet);
    for (int i = mediaEntityList.length - 1; i >= 0; i--) {
      final MediaEntity entity = mediaEntityList[i];
      if (_isPhotoType(entity)) {
        return entity;
      }
    }
    return null;
  }

  static MediaEntity? _gifEntity(TweetV1Response tweet) {
    final List<MediaEntity> mediaEntityList = _allMediaEntities(tweet);
    for (int i = mediaEntityList.length - 1; i >= 0; i--) {
      final MediaEntity entity = mediaEntityList[i];
      if (_isGifType(entity)) {
        return entity;
      }
    }
    return null;
  }

  static bool _hasPhoto(TweetV1Response tweet) {
    return _photoEntity(tweet) != null;
  }

  static bool _hasGif(TweetV1Response tweet) {
    return _gifEntity(tweet) != null;
  }

  static String? _tweetLink(TweetV1Response tweet) {
    if (tweet.id <= 0) {
      return null;
    }
    if (tweet.user.screenName.isEmpty) {
      return "$_TWITTER_URL$_UNKNOWN_SCREEN_NAME/status/${tweet.idStr}";
    } else {
      return "$_TWITTER_URL${tweet.user.screenName}/status/${tweet.idStr}";
    }
  }

  static String? _userLink(TweetV1Response tweet) {
    if (tweet.id <= 0) {
      return null;
    }
    if (tweet.user.screenName.isEmpty) {
      return "$_TWITTER_URL$_UNKNOWN_SCREEN_NAME";
    } else {
      return "$_TWITTER_URL${tweet.user.screenName}";
    }
  }

  static String _text(TweetV1Response tweet) {
    return tweet.text;
  }

  static Runes _runes(TweetV1Response tweet) {
    return tweet.text.runes;
  }

  static String? _profileURL(TweetV1Response tweet) {
    return tweet.user.profileImageUrlHttps;
  }

  static List<String> _allPhotos(TweetV1Response tweet) {
    return tweet.extendedEntities.media.where((MediaEntity mediaEntity) {
      return _isPhotoType(mediaEntity);
    }).map((MediaEntity mediaEntity) {
      return mediaEntity.mediaUrlHttps;
    }).toList(growable: false);
  }

  static String _userName(TweetV1Response tweet) {
    return tweet.user.name;
  }

  static String _userScreenName(TweetV1Response tweet) {
    return tweet.user.screenName;
  }

  static TweetVM? _quotedTweet(
      TweetV1Response? tweet, DateFormat? createdDateDisplayFormat) {
    if (tweet != null) {
      return TweetVM.fromApiModel(tweet, createdDateDisplayFormat);
    } else {
      return null;
    }
  }

  static TweetVM? _retweetedTweet(
      TweetV1Response? tweet, DateFormat? createdDateDisplayFormat) {
    if (tweet != null) {
      return TweetVM.fromApiModel(tweet, createdDateDisplayFormat);
    } else {
      return null;
    }
  }

  static bool _userVerified(TweetV1Response tweet) {
    return tweet.user.verified;
  }

  static String? _videoPlaceholderUrl(TweetV1Response tweet) {
    return _videoEntity(tweet)?.mediaUrlHttps;
  }

  static Map<String, String> _videoUrls(TweetV1Response tweet) {
    final List<Variant>? listOfVideoVariants = _videoEntity(tweet)
        ?.videoInfo
        ?.variants
        .where((variant) => variant.contentType == 'video/mp4')
        .toList();
    listOfVideoVariants?.sort(
        (variantA, variantB) => variantA.bitrate.compareTo(variantB.bitrate));
    if (listOfVideoVariants != null && listOfVideoVariants.isNotEmpty) {
      return Map.fromIterable(listOfVideoVariants,
          key: (dynamic variant) =>
              (variant as Variant).bitrate.toString() + ' kbps',
          value: (dynamic variant) => (variant as Variant).url);
    } else {
      return {};
    }
  }

  static double? _videoAspectRatio(TweetV1Response tweet) {
    VideoInfo? videoInfo = _videoEntity(tweet)?.videoInfo;
    if (videoInfo != null) {
      return videoInfo.aspectRatio[0] / videoInfo.aspectRatio[1];
    } else {
      return null;
    }
  }

  static int? _favoriteCount(TweetV1Response tweet) {
    return tweet.favoriteCount;
  }

  static int? _repliesCount(TweetV1Response tweet) {
    return tweet.replyCount;
  }

  static int _startDisplayText(TweetV1Response tweet) {
    return tweet.displayTextRange != null ? tweet.displayTextRange![0] : 0;
  }

  static int _endDisplayText(TweetV1Response tweet) {
    return tweet.displayTextRange != null
        ? tweet.displayTextRange![1]
        : _runes(tweet).length;
  }

  static bool _favorited(TweetV1Response tweet) {
    return tweet.favorited != null ? tweet.favorited! : false;
  }

  static bool _replied(TweetV1Response tweet) {
    return tweet.replied != null ? tweet.replied! : false;
  }
}
