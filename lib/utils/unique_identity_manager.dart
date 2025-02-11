import 'package:ulid4d/ulid4d.dart';

/// A class to manage unique identities using ULID (Universally Unique Lexicographically Sortable Identifier).
final class UniqueIdentityManager {
  late final _ulIDFactory = ULIDFactory();

  /// Returns the next ULID.
  ULID get _ulID => _ulIDFactory.nextULID();

  /// to get string of ulID used for message id
  String get messageId => _ulID.toString();

  /// generate notification id from message ulId
  int generateNotificationId(String ulId) => _ulIDFactory.fromString(ulId).timestamp.toInt() & 0xFFFFFFF;
}
