# tweet_ui

Flutter Tweet UI - Flutter package that is inspired from [twitter-kit-android](https://github.com/twitter-archive/twitter-kit-android). 

Works on iOS and Android.

## Getting Started

#### If you are using not the stable flutter release - please use the [0.2.0-rc](https://pub.dev/packages/tweet_ui/versions/0.2.0-rc)


To use this package add it to the pubspec.yaml file:

`tweet_ui: <latest_version>`

import it:
 
`import 'package:tweet_ui/tweet_ui.dart';`

and create a `TweetView` from a JSON:

```dart
TweetView.fromTweet(
    Tweet.fromRawJson(
        jsonFromTwitterAPI
        // {"created_at": "Mon Nov 12 13:00:38 +0000 2018", "id": 1061967001177018368, ...
    )
);
```

or a `CompactTweetView`

```dart
CompactTweetView.fromTweet(
    Tweet.fromRawJson(
        jsonFromTwitterAPI
        // {"created_at": "Mon Nov 12 13:00:38 +0000 2018", "id": 1061967001177018368, ...
    )
);
```

There is also a special `QuoteTweetView` that is embedded in a `TweetView` or a `CompactTweetView`. This depends if a Tweet has a `quoted_status` value in the JSON.

## Example of supported view and media types:

> Sample tweets use real life tweet ids but for example purposes their content was changed.

| Variant  |                                            Standard tweet                                             |                                            Compact tweet                                             | Standard Quote tweet                                                                                        | Compact Quote tweet                                                                                        |
|:--------:|:-----------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------|
| 1 photo  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_1_photo.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_1_photo.png)  |
| 2 photos | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_2_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_2_photos.png) |
| 3 photos | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_3_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_3_photos.png) |
| 4 photos | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_4_photos.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_4_photos.png) |
|  video*  |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_video.png)   |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_video.png)   | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_video.png)    | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_video.png)    |
|   GIF    |   ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_gif.png)    |   ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_gif.png)    | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_gif.png)      | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_gif.png)      |

> *If you want to show tweets with videos, please check the [video_player installation](https://pub.dev/packages/video_player#installation).

## Styling Tweets

#### Video player 
By default the `chewie`/`video_player` package is used to show a gif/video, but you can set the `useVideoPlayer` flag to `false` if you want to show a image placeholder provided by the Twitter API and open a video in a new page.

|    Variant     |                                      With video_player/chewie                                      |                                                With placeholder                                                |
|:--------------:|:--------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------:|
| Standard Video | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_video.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_video_placeholder.png) |
| Compact Video  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_video.png)  | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_video_placeholder.png)  |
|  Standard GIF  |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_gif.png)  |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_gif_placeholder.png)  |
|  Compact GIF   |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_gif.png)   |  ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_gif_placeholder.png)   |


#### Text & colors 
All texts are customizable. You can copy from the `defaultxxx`, `defaultCompactxxx` and `defaultQuotexxx`styles like in the example below.

```dart
Card(
    color: Colors.grey,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CompactTweetView.fromTweet(
        Tweet.fromRawJson(
          snapshot.data,
        ),
        useVideoPlayer: false,
        userNameStyle: defaultUserNameStyle.copyWith(fontWeight: FontWeight.w200),
        userScreenNameStyle: defaultUserScreenNameStyle.copyWith(fontWeight: FontWeight.w600),
        textStyle: defaultTextStyle.copyWith(
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.italic,
          shadows: [Shadow(color: Colors.white30)],
        ),
        clickableTextStyle: defaultClickableTextStyle.copyWith(color: Colors.white),
        backgroundColor: Colors.grey,
        quoteUserNameStyle: defaultQuoteUserNameStyle.copyWith(fontWeight: FontWeight.w800),
        quoteUserScreenNameStyle: defaultQuoteUserScreenNameStyle.copyWith(fontWeight: FontWeight.w100),
        quoteTextStyle: defaultQuoteTextStyle.copyWith(fontStyle: FontStyle.italic),
        quoteClickableTextStyle: defaultQuoteClickableTextStyle.copyWith(color: Colors.cyanAccent),
        quoteBorderColor: Colors.blueAccent,
        quoteBackgroundColor: Colors.blueGrey,
      ),
    ),
  );
```

|    Variant    | Standard tweet                                                               | Compact tweet                                                               |
|:-------------:|:-----------------------------------------------------------------------------:|:----------------------------------------------------------------------------:|
| Custom styles | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/standard_quote_custom.png) | ![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/compact_quote_custom.png) |


![img](https://raw.githubusercontent.com/schibsted/tweet_ui/master/screenshots/diagram.jpg)

#### Custom callbacks

onTapImage - function called when user clicks on a image in a TweetView, CompactTweetView or QuoteTweetView.
`typedef OnTapImage = void Function(List<String> allPhotos, int photoIndex, String hashcode);`

```dart

TweetView.fromTweet(
  Tweet.fromRawJson(
    snapshot.data,
  ),
  onTapImage: openImage,
);

  void openImage(List<String> allPhotos, int photoIndex, String hashcode) {
    print("Opened ${allPhotos[photoIndex]}");
  }
```
  
## TODO

1. Get Tweets from Twitter API
2. Write tests
3. Add option to set image quality

## Thanks for contributing: [dasmikko](https://github.com/dasmikko), [jamesblasco](https://github.com/jamesblasco)