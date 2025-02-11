import 'package:drift/drift.dart';

/// This class represents the Message table in the database.
/// It contains columns for [messageId], [message], [senderId], and [createdAt].
@DataClassName('MessageModel')
class MessageTable extends Table {
  /// Unique identifier for each message.
  TextColumn get messageId => text().unique()();

  /// The content of the message.
  TextColumn get message => text()();

  /// Identifier of the sender of the message.
  TextColumn get senderId => text()();

  /// The timestamp when the message was created.
  /// If not provided, it defaults to the current date and time.
  DateTimeColumn get createdAt => dateTime().nullable().withDefault(currentDateAndTime)();
}
