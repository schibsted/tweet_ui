import 'package:tweet_ui/tweet_ui.dart';

import 'test_golden_widget.dart';

void main() async {
  await testGoldenWidget(
    tweetV1WidgetBuilder: (tweet) => EmbeddedTweetView.fromTweetV1(tweet),
    tweetV2WidgetBuilder: (tweet) => EmbeddedTweetView.fromTweetV2(tweet),
    goldenFileName: 'embedded_tweet_view',
  );
}
