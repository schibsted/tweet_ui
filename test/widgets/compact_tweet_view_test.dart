import 'package:tweet_ui/tweet_ui.dart';

import 'test_golden_widget.dart';

void main() async {
  await testGoldenWidget(
    tweetV1WidgetBuilder: (tweet) => CompactTweetView.fromTweetV1(tweet),
    tweetV2WidgetBuilder: (tweet) => CompactTweetView.fromTweetV2(tweet),
    goldenFileName: 'compact_tweet_view',
  );
}
