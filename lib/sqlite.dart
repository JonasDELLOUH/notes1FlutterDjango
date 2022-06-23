import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'note.dart';
class Sqlite {

  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        """ CREATE TABLE IF NOT EXISTS notes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT, text TEXT, date_created, date_updated, isOnline); """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'notes.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> addNote(String title, String? text) async {
    String date = DateTime.now().toString();
    final bd = await Sqlite.db();
      final data = {'title': title, 'text': text, 'date_created': date, 'date_updated': date, 'isOnline': 'false'};
      final id = await bd.insert('notes', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      print("adding note.......");
      return id;
  }

  static Future<int> updateNote(int id, String newTitle, String? newText) async {
    final db = await Sqlite.db();

    final data = {
      'title': newTitle,
      'text': newText,
      'date_updated': DateTime.now().toString()
    };
    final result =
    await db.update('notes', data, where: "id = ?", whereArgs: [id]);
    print("updating............");
    return result;
  }

  static Future<int> updateNoteOnline(int id) async {
    final db = await Sqlite.db();

    final data = {
      'isOnline': true,
    };
    final result =
    await db.update('notes', data, where: "id = ?", whereArgs: [id]);
    print("updating............");
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final db = await Sqlite.db();
    try {
      await db.delete("notes", where: "id = ?", whereArgs: [id]);
      print("deleting...........");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<Note>> retrieveNotes() async {
    final db = await Sqlite.db();
    final List<Map<String, Object?>> queryResult = await db.query('notes', orderBy: "id");
    print("select all notes");
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

  static Future<List<Note>> selectAllNoteOffLine() async {
    final db = await Sqlite.db();
    final List<Map<String, Object?>> queryResult = await db.query('notes', orderBy: "id", where: "isOnline = ?", whereArgs: ['false']);
    print("select all offline notes");
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

}