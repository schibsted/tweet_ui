/// Provides metadata and additional contextual information about content posted on Twitter
abstract class Entity {
  static const START_INDEX = 0;
  static const int END_INDEX = 1;

  /// An array of integers indicating the offsets within the Tweet text where the Entity begins and ends.
  ///
  /// Symbols:
  /// The first integer represents the location of the $ character in the Tweet text string.
  /// The second integer represents the location of the first character after the cashtag.
  /// Therefore the difference between the two numbers will be the length of the hashtag name plus one (for the ‘$’ character).
  ///
  /// Urls:
  /// An array of integers representing offsets within the Tweet text where the URL begins and ends.
  /// The first integer represents the location of the first character of the URL in the Tweet text.
  /// The second integer represents the location of the first non-URL character after the end of the URL.
  ///
  /// Hashtags:
  /// An array of integers indicating the offsets within the Tweet text where the hashtag begins and ends.
  /// The first integer represents the location of the # character in the Tweet text string.
  /// The second integer represents the location of the first character after the hashtag.
  /// Therefore the difference between the two numbers will be the length of the hashtag name plus one (for the ‘#’ character).
  ///
  /// Media:
  /// An array of integers indicating the offsets within the Tweet text where the URL begins and ends.
  /// The first integer represents the location of the first character of the URL in the Tweet text.
  /// The second integer represents the location of the first non-URL character occurring after the URL (or the end of the string if the URL is the last part
  /// of the Tweet text).
  ///
  /// User mentions:
  /// An array of integers representing the offsets within the Tweet text where the user reference begins and ends.
  /// The first integer represents the location of the ‘@’ character of the user mention.
  /// The second integer represents the location of the first non-screenname character following the user mention.
  List<int> indices;

  Entity({
    required this.indices,
  });

  int get start {
    return indices[START_INDEX];
  }

  int get end {
    return indices[END_INDEX];
  }
}
