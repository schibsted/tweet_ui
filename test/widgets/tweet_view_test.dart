import 'package:tweet_ui/tweet_ui.dart';

import 'test_golden_widget.dart';

void main() async {
  await testGoldenWidget(
    tweetV1WidgetBuilder: (tweet) => TweetView.fromTweetV1(tweet),
    tweetV2WidgetBuilder: (tweet) => TweetView.fromTweetV2(tweet),
    goldenFileName: 'tweet_view',
  );
}
