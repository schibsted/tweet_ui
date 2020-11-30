import 'package:intl/intl.dart';
import 'package:tweet_ui/models/api/entieties/entity.dart';
import 'package:tweet_ui/models/api/entieties/media_entity.dart';
import 'package:tweet_ui/models/api/entieties/tweet_entities.dart';
import 'package:tweet_ui/models/api/tweet.dart';

class TweetVM {
  static const String _PHOTO_TYPE = "photo";
  static const String _VIDEO_TYPE = "video";
  static const String _GIF_TYPE = "animated_gif";
  static const String _TWITTER_URL = "https://twitter.com/";
  static const String _UNKNOWN_SCREEN_NAME = "twitter_unknown";

  final String createdAt;
  final bool hasSupportedVideo;
  final List<Entity> allEntities;
  final bool hasPhoto;
  final bool hasGif;
  final String tweetLink;
  final String userLink;
  final String text;
  final Runes textRunes;
  final String profileUrl;
  final List<String> allPhotos;
  final String userName;
  final String userScreenName;
  final TweetVM quotedTweet;
  final TweetVM retweetedTweet;
  final bool userVerified;
  final String videoPlaceholderUrl;
  final Map<String, String> videoUrls;
  final double videoAspectRatio;
  final int favoriteCount;
  final int startDisplayText;
  final int endDisplayText;
  final bool favorited;

  TweetVM({
    this.createdAt,
    this.hasSupportedVideo,
    this.allEntities,
    this.hasPhoto,
    this.hasGif,
    this.tweetLink,
    this.userLink,
    this.text,
    this.textRunes,
    this.profileUrl,
    this.allPhotos,
    this.userName,
    this.userScreenName,
    this.quotedTweet,
    this.retweetedTweet,
    this.userVerified,
    this.videoPlaceholderUrl,
    this.videoUrls,
    this.videoAspectRatio,
    this.favoriteCount,
    this.startDisplayText,
    this.endDisplayText,
    this.favorited,
  });

  factory TweetVM.fromApiModel(
          Tweet tweet, DateFormat createdDateDisplayFormat) =>
      new TweetVM(
        createdAt: _createdAt(tweet, createdDateDisplayFormat),
        hasSupportedVideo: _hasSupportedVideo(_originalTweetOrRetweet(tweet)),
        allEntities: _allEntities(_originalTweetOrRetweet(tweet)),
        hasPhoto: _hasPhoto(_originalTweetOrRetweet(tweet)),
        hasGif: _hasGif(_originalTweetOrRetweet(tweet)),
        tweetLink: _tweetLink(tweet),
        userLink: _userLink(tweet),
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
        videoPlaceholderUrl:
            _videoPlaceholderUrl(_originalTweetOrRetweet(tweet)),
        videoUrls: _videoUrls(_originalTweetOrRetweet(tweet)),
        videoAspectRatio: _videoAspectRatio(_originalTweetOrRetweet(tweet)),
        favoriteCount: _favoriteCount(tweet),
        startDisplayText: _startDisplayText(_originalTweetOrRetweet(tweet)),
        endDisplayText: _endDisplayText(_originalTweetOrRetweet(tweet)),
        favorited: _favorited(tweet),
      );

  static Tweet _originalTweetOrRetweet(tweet) {
    return tweet.retweetedStatus != null ? tweet.retweetedStatus : tweet;
  }

  static String _createdAt(Tweet tweet, DateFormat displayFormat) {
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

  static bool _hasSupportedVideo(Tweet tweet) {
    final MediaEntity entity = _videoEntity(tweet);
    return entity != null;
  }

  static MediaEntity _videoEntity(Tweet tweet) {
    try {
      return _allMediaEntities(tweet).firstWhere(
        (MediaEntity mediaEntity) =>
            mediaEntity.type != null && _isVideoType(mediaEntity),
      );
    } catch (e) {
      return null;
    }
  }

  static List<MediaEntity> _allMediaEntities(Tweet tweet) {
    final List<MediaEntity> allEntities = [];
    final TweetEntities entities = tweet.entities;
    final TweetEntities extendedEntities = tweet.extendedEntities;
    if (entities != null && entities.media != null) {
      allEntities.addAll(entities.media);
    }
    if (extendedEntities != null && extendedEntities.media != null) {
      allEntities.addAll(extendedEntities.media);
    }
    return allEntities;
  }

  static List<Entity> _allEntities(Tweet tweet) {
    final List<Entity> allEntities = [];
    final TweetEntities entities = tweet.entities;

    if (entities != null) {
      if (entities.media != null) {
        allEntities.addAll(entities.media);
      }
      if (entities.hashtags != null) {
        allEntities.addAll(entities.hashtags);
      }
      if (entities.symbols != null) {
        allEntities.addAll(entities.symbols);
      }
      if (entities.urls != null) {
        allEntities.addAll(entities.urls);
      }
      if (entities.userMentions != null) {
        allEntities.addAll(entities.userMentions);
      }
    }
    allEntities.sort((a, b) => a.start.compareTo(b.start));
    return allEntities;
  }

//
  static MediaEntity _photoEntity(Tweet tweet) {
    final List<MediaEntity> mediaEntityList = _allMediaEntities(tweet);
    for (int i = mediaEntityList.length - 1; i >= 0; i--) {
      final MediaEntity entity = mediaEntityList[i];
      if (entity.type != null && _isPhotoType(entity)) {
        return entity;
      }
    }
    return null;
  }

  static MediaEntity _gifEntity(Tweet tweet) {
    final List<MediaEntity> mediaEntityList = _allMediaEntities(tweet);
    for (int i = mediaEntityList.length - 1; i >= 0; i--) {
      final MediaEntity entity = mediaEntityList[i];
      if (entity.type != null && _isGifType(entity)) {
        return entity;
      }
    }
    return null;
  }

  static bool _hasPhoto(Tweet tweet) {
    return _photoEntity(tweet) != null;
  }

  static bool _hasGif(Tweet tweet) {
    return _gifEntity(tweet) != null;
  }

  static String _tweetLink(Tweet tweet) {
    if (tweet.id <= 0) {
      return null;
    }
    if (tweet.user.screenName.isEmpty) {
      return "$_TWITTER_URL$_UNKNOWN_SCREEN_NAME/status/${tweet.idStr}";
    } else {
      return "$_TWITTER_URL${tweet.user.screenName}/status/${tweet.idStr}";
    }
  }

  static String _userLink(Tweet tweet) {
    if (tweet.id <= 0) {
      return null;
    }
    if (tweet.user.screenName.isEmpty) {
      return "$_TWITTER_URL$_UNKNOWN_SCREEN_NAME";
    } else {
      return "$_TWITTER_URL${tweet.user.screenName}";
    }
  }

  static String _text(Tweet tweet) {
    return tweet.text;
  }

  static Runes _runes(Tweet tweet) {
    return tweet.text.runes;
  }

  static String _profileURL(Tweet tweet) {
    return tweet.user.profileImageUrlHttps;
  }

  static List<String> _allPhotos(Tweet tweet) {
    return tweet.extendedEntities?.media?.where((MediaEntity mediaEntity) {
      return _isPhotoType(mediaEntity);
    })?.map((MediaEntity mediaEntity) {
      return mediaEntity.mediaUrlHttps;
    })?.toList(growable: false);
  }

  static String _userName(Tweet tweet) {
    return tweet.user.name;
  }

  static String _userScreenName(Tweet tweet) {
    return tweet.user.screenName;
  }

  static TweetVM _quotedTweet(
      Tweet tweet, DateFormat createdDateDisplayFormat) {
    if (tweet != null) {
      return TweetVM.fromApiModel(tweet, createdDateDisplayFormat);
    } else {
      return null;
    }
  }

  static TweetVM _retweetedTweet(
      Tweet tweet, DateFormat createdDateDisplayFormat) {
    if (tweet != null) {
      return TweetVM.fromApiModel(tweet, createdDateDisplayFormat);
    } else {
      return null;
    }
  }

  static bool _userVerified(Tweet tweet) {
    return tweet.user.verified;
  }

  static String _videoPlaceholderUrl(Tweet tweet) {
    return _videoEntity(tweet)?.mediaUrlHttps;
  }

  static Map<String, String> _videoUrls(Tweet tweet) {
    var listOfVideoVariants = _videoEntity(tweet)
        ?.videoInfo
        ?.variants
        ?.where((variant) => variant.contentType == 'video/mp4')
        ?.toList();
    listOfVideoVariants?.sort(
        (variantA, variantB) => variantA.bitrate.compareTo(variantB.bitrate));
    if (listOfVideoVariants?.isNotEmpty ?? false) {
      return Map.fromIterable(listOfVideoVariants,
          key: (dynamic variant) =>
              // ignore: null_aware_before_operator
              (variant as Variant)?.bitrate?.toString() + ' kbps',
          value: (dynamic variant) => (variant as Variant)?.url);
    } else {
      return null;
    }
  }

  static double _videoAspectRatio(Tweet tweet) {
    VideoInfo videoInfo = _videoEntity(tweet)?.videoInfo;
    if (videoInfo != null) {
      return videoInfo?.aspectRatio[0] / videoInfo?.aspectRatio[1];
    } else {
      return null;
    }
  }

  static int _favoriteCount(Tweet tweet) {
    return tweet.favoriteCount;
  }

  static int _startDisplayText(Tweet tweet) {
    return tweet.displayTextRange != null ? tweet.displayTextRange[0] : 0;
  }

  static int _endDisplayText(Tweet tweet) {
    return tweet.displayTextRange != null
        ? tweet.displayTextRange[1]
        : _runes(tweet).length;
  }

  static bool _favorited(Tweet tweet) {
    return tweet.favorited != null ? tweet.favorited : false;
  }
}

extension ExtendedText on TweetVM {
  TweetVM getDisplayTweet() {
    if (this.retweetedTweet != null) {
      return retweetedTweet;
    } else {
      return this;
    }
  }
}
