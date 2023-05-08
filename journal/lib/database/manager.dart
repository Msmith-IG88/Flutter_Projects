import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../components/entry_model.dart';

class DatabaseManager {
  static DatabaseManager _instance;
  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String SCHEMA_FILENAME = 'assets/schema_1.sql.txt';
  static const String SQL_INSERT_ENTRY = 'INSERT INTO journal_entries(title, body, rating, date) VALUES (?, ?, ?, ?)';
  static const String SQL_GET_ENTRIES = 'SELECT * FROM journal_entries';

  final Database db;
  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      final String createSchema = await rootBundle.loadString(SCHEMA_FILENAME);

      createTables(db, createSchema);
    });
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry(JournalEntry entry) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT_ENTRY,
          [entry.title, entry.body, entry.rating, entry.date.toString()]);
    });
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    final journalRecords = await db.rawQuery(SQL_GET_ENTRIES);

    final journalEntries = journalRecords.map((record) {
      return JournalEntry(
        title: record['title'],
        body: record['body'],
        rating: record['rating'],
        date: DateTime.parse(record['date']),
      );
    }).toList();
    return journalEntries;
  }
}
