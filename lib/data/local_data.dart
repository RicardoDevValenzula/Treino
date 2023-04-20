// @dart=2.9
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:treino/data/LoginModel.dart';

class LocalData {
  LocalData._();
  static final LocalData db = LocalData._();

  static LoginModel user;
  static Database _database;
  static LatLng savedPos;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {    
    String directory = await getDatabasesPath();
    String path = join(directory, "treino.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
    onCreate: (Database db, int version) async {
      await db.execute('''DROP TABLE IF EXISTS user_login''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS user_login (
          user TEXT PRIMARY_KEY,
          password TEXT
        );
      ''');      
      
      await db.execute('''DROP TABLE IF EXISTS persistance''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS persistance (
          ignored TEXT PRIMARY_KEY
        );
      ''');
    }
    );
  }
  
  registerPersistance() async {
    final db = await database;
    db.insert('persistance', {
      "ignored": 1
    });
  }

  queryUser() async {
    final db = await database;
    var user_db = await db.query("user_login");
    return user_db;
  }

  queryPersistance() async {
    final db = await database;
    var user_db = await db.query("persistance");
    return user_db;
  }

  removeUser() async {
    final db = await database;
    var user_db = await db.delete("user_login");
    print(user_db);
  }

  addUser(LoginModel newUser) async {
    LocalData.user = newUser;
    final db = await database;
    await db.insert("user_login", {
      "user": newUser.user,
      "password": newUser.pass
    });
  }
}
