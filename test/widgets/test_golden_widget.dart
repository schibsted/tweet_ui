import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tweet_ui/tweet_ui.dart';

typedef TweetV1WidgetBuilder = Widget Function(TweetV1Response tweetV1);
typedef TweetV2WidgetBuilder = Widget Function(TweetV2Response tweetV2);

Future<void> testGoldenWidget({
  required TweetV1WidgetBuilder tweetV1WidgetBuilder,
  required TweetV2WidgetBuilder tweetV2WidgetBuilder,
  required String goldenFileName,
}) async {
  final fileTweetV1 = File('test_resources/tweet_v1.json');
  final tweetV1 = TweetV1Response.fromRawJson(await fileTweetV1.readAsString());

  final fileTweetV2 = File('test_resources/tweet_v2.json');
  final tweetV2 = TweetV2Response.fromRawJson(await fileTweetV2.readAsString());

  testGoldens('Tweet view should be rendered properly',
      (WidgetTester tester) async {
    await loadAppFonts();

    final builder = GoldenBuilder.column()
      ..addScenario('Tweet V1', tweetV1WidgetBuilder(tweetV1))
      ..addScenario('Tweet V2', tweetV2WidgetBuilder(tweetV2));

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(tester, goldenFileName);
  });
}
