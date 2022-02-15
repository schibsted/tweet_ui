import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_v2.g.dart';

/// The user object contains Twitter user account metadata describing the referenced user.
/// The user object is the primary object returned in the users lookup endpoint.
/// When requesting additional user fields on this endpoint, simply use the fields parameter user.fields.
///
/// The user object can also be found as a child object and expanded in the Tweet object.
/// The object is available for expansion with ?expansions=author_id or ?expansions=in_reply_to_user_id to get the condensed object with only default fields.
/// Use the expansion with the field parameter: user.fields when requesting additional fields to complete the object.
@JsonSerializable()
class UserV2 {
  /// The unique identifier of this user.
  final String id;

  /// The name of the user, as they’ve defined it on their profile.
  /// Not necessarily a person’s name. Typically capped at 50 characters, but subject to change.
  final String name;

  /// The Twitter screen name, handle, or alias that this user identifies themselves with.
  /// Usernames are unique but subject to change.
  /// Typically a maximum of 15 characters long, but some historical accounts may exist with longer names.
  final String username;

  /// A URL provided by a Twitter user in their profile. This could be a homepage, but is not always the case.
  @JsonKey(name: "profile_image_url")
  final String? profileImageUrl;

  /// Indicates whether or not this Twitter user has a verified account.
  /// A verified account lets people know that an account of public interest is authentic.
  final bool? verified;

  const UserV2({
    required this.id,
    required this.name,
    required this.username,
    this.profileImageUrl,
    this.verified = false,
  });

  factory UserV2.fromRawJson(String str) => UserV2.fromJson(json.decode(str));

  factory UserV2.fromJson(Map<String, dynamic> json) => _$UserV2FromJson(json);
}
