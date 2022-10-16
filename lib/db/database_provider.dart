import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/note_model.dart';

const _tableName = 'notes';
const _pathName = 'note_app.db';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), _pathName),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          creation_date DATE
        )
      ''');
    }, version: 1);
  }

  addNewNote(NoteModel note) async {
    final db = await database;
    db?.insert(_tableName, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  getNotes() async {
    final db = await database;
    var res = await db?.query(_tableName);
    if (res?.length == 0) {
      return Null;
    } else {
      var resultMap = res!.toList();
      if (resultMap.isEmpty) return null;

      List<NoteModel> noteBase = [];
      for (var a in resultMap) {
        noteBase.add(NoteModel.fromJson(a));
      }

      return noteBase;
    }
  }

  deleteNote(int id) async {
    final db = await database;
    int count =
        await db!.rawDelete("DELETE FROM $_tableName WHERE id = ?", [id]);
    return count;
  }

  changeNote(NoteModel note) async {
    final db = await database;
    var set = await db!.rawUpdate(
        "UPDATE $_tableName SET title = ?, body = ? WHERE id = ?", [note.title , note.body , note.id]);
  }
}
