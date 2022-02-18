import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tweet_ui/models/api/v1/entieties/symbol_entity.dart';
import 'package:tweet_ui/models/api/v2/entities/entity_v2.dart';

part 'cashtag_entity_v2.g.dart';

/// Represents cashtag which have been parsed out of the Tweet text.
///
/// A cashtag is a company ticker symbol preceded by the U.S. dollar sign, e.g. $TWTR.
/// When you click on a cashtag, you'll see other Tweets mentioning that same ticker symbol.
@JsonSerializable()
class CashtagEntityV2 extends EntityV2 {
  /// The cashtag value, without leading '$' sign
  final String tag;

  const CashtagEntityV2({
    required this.tag,
    required int start,
    required int end,
  }) : super(start: start, end: end);

  factory CashtagEntityV2.fromRawJson(String str) =>
      CashtagEntityV2.fromJson(json.decode(str));

  factory CashtagEntityV2.fromJson(Map<String, dynamic> json) =>
      _$CashtagEntityV2FromJson(json);

  SymbolEntity toV1() => SymbolEntity(text: tag, indices: [start, end]);
}
