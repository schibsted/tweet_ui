# tweet_ui

Flutter Tweet UI - Flutter package that is inspired by
[twitter-kit-android](https://github.com/twitter-archive/twitter-kit-android). Works on iOS and Android.

## Getting Started

To use this package add it to the pubspec.yaml file:

`tweet_ui: <latest_version>`

import it:

`import 'package:tweet_ui/tweet_ui.dart';`

If you want to show tweets with videos: check the
[better_player installation]( https://jhomlala.github.io/betterplayer/#/install) site

> Video/GIF Tweets don't work on iOS simulators ([video_player ios instructions](https://pub.dev/packages/video_player#ios))


finally, create a `TweetView` from a JSON:

### API V1.1
```dart
TweetView.fromTweetV1(
    TweetV1Response.fromRawJson(
        jsonFromTwitterAPI
        // {"created_at": "Mon Nov 12 13:00:38 +0000 2018", "id": 1061967001177018368, ...
    )
);
```
### API V2
```dart
TweetView.fromTweetV2(
    TweetV2Response.fromRawJson(
        jsonFromTwitterAPI
        // {"data": ["created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
        // or
        // {"data": {"created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
    )
);
```

or a `CompactTweetView`,

### API V1.1
```dart
CompactTweetView.fromTweetV1(
    TweetV1Response.fromRawJson(
        jsonFromTwitterAPI
        // {"created_at": "Mon Nov 12 13:00:38 +0000 2018", "id": 1061967001177018368, ...
    )
);
```

### API V2
```dart
CompactTweetView.fromTweetV2(
    TweetV2Response.fromRawJson(
        jsonFromTwitterAPI
        // {"data": ["created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
        // or
        // {"data": {"created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
    )
);
```

or a `EmbeddedTweetView`.

### API V1.1
```dart
EmbeddedTweetView.fromTweetV1(
    TweetV1Response.fromRawJson(
        jsonFromTwitterAPI
        // {"created_at": "Mon Nov 12 13:00:38 +0000 2018", "id": 1061967001177018368, ...
    )
  darkMode: true,
)
```

### API V2
```dart
EmbeddedTweetView.fromTweetV2(
    TweetV2Response.fromRawJson(
      jsonFromTwitterAPI
      // {"data": ["created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
      // or
      // {"data": {"created_at": "2020-09-18T18:36:15.000Z", "id": "1061967001177018368", ...
    )
    darkMode: true,
)
```

There is also a special `QuoteTweetView` that is embedded in a `TweetView` or a `CompactTweetView` or a
`EmbeddedTweetView`. This depends if a Tweet has a `quoted_status` value in the JSON.

## What tweet view should I create?

`TweetView` and `CompactTweetView` are more customisable, but `EmbeddedTweetView` looks more modern. Check the screenshots [below](https://github.com/schibsted/tweet_ui#example-of-supported-view-and-media-types).

## Twitter API V2 know problems
In current version of twitter API (V2 as of 14.02.2022) it is not possible to get video url in tweet response.
See the following links for more info:
- [Twitter community](https://twittercommunity.com/t/where-would-i-find-the-direct-link-to-an-mp4-video-posted-in-v2/146933/2)
- [Twitter dev feedback](https://twitterdevfeedback.uservoice.com/forums/930250-twitter-api/suggestions/41291761-media-fields-should-return-url-for-gifs-or-videos)

All other video fields (like size or duration) are available in the response. 
This means that videos will not work for now.

## Need more information? Check our wiki pages!

[Colors & styling](https://github.com/schibsted/tweet_ui/wiki/Colors-&-styling)

[Custom callbacks](https://github.com/schibsted/tweet_ui/wiki/Custom-callbacks)

[Custom date format](https://github.com/schibsted/tweet_ui/wiki/Custom-date-format)

[Video player options](https://github.com/schibsted/tweet_ui/wiki/Video-player-options)

## Example of supported view and media types:

### Standard tweet views

| Media type |                                               TweetView                                               |                                           CompactTweetView                                           | EmbeddedTweetView                                                                                     |
|:----------:|:-----------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------|
|  1 photo   | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_1_photo.png)  |
|  2 photos  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_2_photos.png) |
|  3 photos  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_3_photos.png) |
|  4 photos  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_4_photos.png) |
|   video    |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_video.png)   |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_video.png)   | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_video.png)    |
|    GIF     |   ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_gif.png)    |   ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_gif.png)    | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_gif.png)      |

### Quoted tweet views

| Media type |                                                  TweetView                                                  |                                              CompactTweetView                                              | EmbeddedTweetView                                                                                           |
|:----------:|:-----------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------|
|  1 photo   | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_quote_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_quote_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_quote_1_photo.png)  |
|  2 photos  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_quote_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_quote_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_quote_2_photos.png) |
|  3 photos  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_quote_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_quote_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_quote_3_photos.png) |
|  4 photos  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_quote_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_quote_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_quote_4_photos.png) |
|   video    |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_quote_video.png)   |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_quote_video.png)   | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_quote_video.png)    |
|    GIF     |   ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/standard_quote_gif.png)    |   ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/compact_quote_gif.png)    | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/dev/screenshots/embedded_quote_gif.png)      |

> Sample tweets use real-life tweet ids but for example purposes, their content was changed.

***

#### Thanks for contributing: [dasmikko](https://github.com/dasmikko), [jamesblasco](https://github.com/jamesblasco), [tristan-vrt](https://github.com/tristan-vrt), [daver123](https://github.com/daver123), [ercadev](https://github.com/ercadev), [ivanjpg](https://github.com/ivanjpg), [escamoteur](https://github.com/escamoteur), [ndahlquist](https://github.com/ndahlquist), [wszeborowskimateusz](https://github.com/wszeborowskimateusz), [robertmrobo](https://github.com/robertmrobo)