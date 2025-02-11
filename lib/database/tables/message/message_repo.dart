import 'package:chat_sdk/database/data_base.dart';
import 'package:chat_sdk/database/tables/message/message_table.dart';
import 'package:drift/drift.dart';

///
class MessageRepo {
  /// Default constructor
  MessageRepo({required this.instance});

  /// Database instance
  final AppDatabase instance;

  /// Table for managing [MessageTable] data.
  late final table = instance.messageTable;

  /// Manager for the [MessageTable].
  late final manager = instance.managers.messageTable;

  /// Retrieves all [MessageTable] records from the database.
  ///
  /// Returns a [Future] that completes with a list of [MessageTable] objects.
  Future<List<MessageModel>> getAllTodos() async {
    return table.all().get();
  }

  /// Adds a new [MessageTable] record to the database.
  ///
  /// The [companion] parameter is a [MessageTableCompanion] object that represents the new record to be added.
  ///
  /// Returns a [Future] that completes when the insertion is done.
  Future<void> addTodo(MessageTableCompanion companion) async {
    await table.insertOne(companion);
  }

  /// Get Tod0 Object from id
  ///
  /// Retrieves a single [MessageModel] record from the database based on the provided [id].
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the record to retrieve.
  ///
  /// Returns:
  /// A [Future] that completes with a [MessageModel] object if found, or `null` if no record is found.
  Future<MessageModel>? getTodoById(String id) {
    return (instance.select(table)..where((a) => a.messageId.equals(id))).getSingle();
  }
}
