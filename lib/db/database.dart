import 'dart:async';

import 'package:code_talks_demo/db/todo_model.dart';
import 'package:path/path.dart';

// works on apps only, for web you need drift
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'code.talks.demo.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Todo ('
          'id INTEGER PRIMARY KEY,'
          'action TEXT,'
          'description TEXT,'
          'checked BOOLEAN NOT NULL CHECK (checked IN (0, 1))'
          ')');
    });
  }

  newTodo(Todo newTodo) async {
    final db = await database;
    var table = await db.rawQuery('SELECT MAX(id)+1 as id FROM Todo');
    int? id = Sqflite.firstIntValue(table);
    var raw = await db.rawInsert(
        'INSERT Into Todo (id,action,description,checked)'
        ' VALUES (?,?,?,?)',
        [
          id,
          newTodo.action,
          newTodo.description,
          newTodo.checked,
        ]);
    return raw;
  }

  updateTodo(Todo newTodo) async {
    final db = await database;
    var res = await db.update('Todo', newTodo.toMap(),
        where: 'id = ?', whereArgs: [newTodo.id]);
    return res;
  }

  getTodo(int id) async {
    final db = await database;
    var res = await db.query('Todo', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromMap(res.first) : null;
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    var res = await db.query('Todo');
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  deleteTodo(int id) async {
    final db = await database;
    return db.delete('Todo', where: 'id = ?', whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete('Delete * from Todo');
  }
}
