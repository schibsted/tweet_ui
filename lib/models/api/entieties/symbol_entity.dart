import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents symbols which have been parsed out of the Tweet text.
class SymbolEntity extends Entity {
  /// Name of the cashhtag, minus the leading ‘$’ character.
  String text;

  SymbolEntity({
    required this.text,
    required indices,
  }) : super(indices: indices);

  factory SymbolEntity.fromRawJson(String str) =>
      SymbolEntity.fromJson(json.decode(str));

  factory SymbolEntity.fromJson(Map<String, dynamic> json) => new SymbolEntity(
        text: json["text"] == null ? null : json["text"],
        indices: json["indices"] == null
            ? null
            : new List<int>.from(json["indices"].map((x) => x)),
      );
}
