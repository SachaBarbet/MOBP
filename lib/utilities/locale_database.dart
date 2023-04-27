import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../models/user.dart';

class LocaleDatabase {
  static late Database db;
  static bool connected = false;

  static Future<void> initData() async {
    // CONNECTION A LA BASE DE DONNEE LOCAL
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "db_sqflite.db");

    // Ouverture de la db pour la première fois
    onCreate(Database db, int version) async {
      // Database is created, create the tables and default data
      await db.execute(
          "CREATE TABLE UserData (dataID TEXT PRIMARY KEY, value TEXT)");
      // Insert default settings
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('login', '')");
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('password', '')");
      // pas utilisé pour le moment
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('keepLogin', '0')");
    }
    // Check si le répertoire de la db exist
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    db = await openDatabase(path,
        version: 1,
        onCreate: onCreate);
  }

  static Future<void> setUser() async {
    String login = await db.query('UserData', where: 'dataID = ?', whereArgs: ['login']).then((value) => value[0]['value'] as String);
    String password = await db.query('UserData', where: 'dataID = ?', whereArgs: ['password']).then((value) => value[0]['value'] as String);
    AppUser.login = login; AppUser.password= password;
  }

  static Future<void> insert(String table, Map<String, dynamic> values) async {
    await db.insert(table, values, conflictAlgorithm: ConflictAlgorithm.replace,);
  }
}