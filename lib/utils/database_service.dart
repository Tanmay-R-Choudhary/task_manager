import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final _dbName = "todo.db";
  static final _dbVersion = 1;
  static final _tableName = "data";

  static final columnID = "_id";
  static final columnUser = "user";
  static final columnDay = "weekday";
  static final columnHeading = "title";
  static final columnDescription = 'description';
  static final columnDeadlineDate = "date";
  static final columnDeadlineMonth = "month";
  static final columnDeadlineYear = "year";
  static final columnPriority = "priority";

  static final instance = DatabaseService._internal();
  factory DatabaseService() => instance;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName(
        $columnID INTEGER PRIMARY KEY,
        $columnUser TEXT NOT NULL,
        $columnDay INTEGER NOT NULL,
        $columnHeading TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnDeadlineDate INTEGER NOT NULL,
        $columnDeadlineMonth INTEGER NOT NULL,
        $columnDeadlineYear INTEGER NOT NULL,
        $columnPriority INTEGER NOT NULL
      );
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnID];
    return await db
        .update(_tableName, row, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnID = ?', whereArgs: [id]);
  }
}
