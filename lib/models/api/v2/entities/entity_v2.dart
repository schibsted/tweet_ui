/// Entities are JSON objects that provide additional information about hashtags, urls, user mentions,
/// and cashtags associated with a Tweet. Reference each respective entity for further details.
//
// Please note that all start indices are inclusive. The majority of end indices are exclusive,
// except for entities.annotations.end, which is currently inclusive. We will be changing this to exclusive with our
// v3 bump since it is a breaking change.
abstract class EntityV2 {
  final int start;
  final int end;

  const EntityV2({
    required this.start,
    required this.end,
  });
}
