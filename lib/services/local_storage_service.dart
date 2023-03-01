import 'package:mobp/models/database_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobp/models/tables/procedure.dart';

class LocalStorageService {

  Future<Database> initLocalDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),

      onCreate: (db, version) {
        return db.execute('CREATE TABLE Procedures(id INTEGER PRIMARY KEY, name TEXT, description TEXT, software TEXT)');
      },
    version: 1,
    );
  }

  Future<void> insert(Database database, DatabaseTable table) async {
    final db = database;
    await db.insert(
      table.tableName,
      table.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DatabaseTable>> values(Database database, String tableName) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Procedure(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        software: maps[i]['software'],
      );
    });
  }

  Future<void> update(Database database, DatabaseTable table) async {
    final db = database;

    await db.update(
      table.tableName,
      table.toMap(),
      where: 'id = ?',
      whereArgs: [table.columns['id']],
    );
  }

  Future<void> delete(Database database, String tableName, int id) async {
    final db = database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}