import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/dog_model.dart';

class DBHelper {
  //make this class singleton class (we can create object for a single time only)
  DBHelper._();
  static final DBHelper db = DBHelper._();

  //only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    //this case apply if database is already exist
    if (_database != null) {
      return _database;
    }

    //this case will apply to create new databse
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Dogs.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE dog_tbl (id INTEGER PRIMARY KEY ,name TEXT,age INTEGER)');
    });
  }

  Future<int> insertDog(Dog dog) async {
    int result = 0;
    final Database db = await initDB();
    result = await db.insert('dog_tbl', dog.toMap());
    // print(result);
    return result;
  }

  Future<List<Dog>> retriveDog() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> queryResult = await db.query('dog_tbl');
    return queryResult
        .map((Map<String, dynamic> dogItem) => Dog.fromMap(dogItem))
        .toList();
  }

  Future<void> deleteDog(dogId) async {
    final Database db = await initDB();
    await db.delete('dog_tbl', where: 'id=?', whereArgs: [dogId]);
  }

  Future<int> updateDog(Dog upDog, id) async {
    final Database db = await initDB();
    print(upDog.toMap());
    var updated = await db
        .update('dog_tbl', upDog.toMap(), where: 'id=?', whereArgs: [id]);
    return updated;
  }

  // Future<int> updateDog(Dog upDog) async {
  //   int updated = 0;
  //   final Database db = await initDB();
  //   updated = await db
  //       .update('dog_tbl', upDog.toMap(), where: 'id=?', whereArgs: [upDog.id]);
  //   return updated;
  // }
}
