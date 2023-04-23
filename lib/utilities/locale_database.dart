import 'package:mobp/models/user_data.dart';
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
      // Database is created, create the table
      await db.execute(
          "CREATE TABLE UserData (dataID TEXT PRIMARY KEY, value TEXT)");
      await db.execute(
          "CREATE TABLE Process (processID INTEGER PRIMARY KEY, value TEXT)");
      await db.execute(
          "CREATE TABLE Folder (folderID INTEGER PRIMARY KEY, value TEXT)");
      // Insert default settings
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('distantDbVersion', '0')");
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('localDbVersion', '0')");
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('login', '')");
      await db.execute(
          "INSERT INTO UserData (dataID, value) VALUES ('password', '')");
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

  static Future<Map<String, Object>> getTableData(String table, {Map<String, dynamic> filter = const {}}) async {
    String whereStr = '';
    List whereArgs = <dynamic>[];
    int count = 1;
    if (filter.isNotEmpty) {filter.forEach((key, value) {
      whereArgs.add(value);
      whereStr += "$key = ?";});
      if (filter.length != count) {whereStr += ", ";}
      count++;
    }

    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: whereStr,
      whereArgs: whereArgs,
    );

    Map<String, Object> result = {};
    switch (table) {
      case 'UserData':
        for (var element in maps) {
          result[element['dataID']] = Setting(settingID: element['dataID'], value: element['value']);
        }
        break;
    }
    return result;
  }

  static Future<void> update() async {

  }

  static Future<void> delete() async {

  }

  static syncFromRemote() {

  }
}