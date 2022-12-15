import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/Pet_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        age INTEGER,
        species TEXT,
        behaviour TEXT,
        MD TEXT
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'kindacode.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String name, String age, String species,String behaviour, String md) async {
    final db = await SQLHelper.db();
    //var pet = Pet(name, age, species, behaviour, md);
    final data = {'name': name, 'age': age, 'species':species,'behaviour':behaviour, 'md':md };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<Future<List<Map<String, Object?>>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String name, String age, String species,String behaviour, String md) async {
    final db = await SQLHelper.db();

    // final data = {
    //   'title': title,
    //   'description': descrption,
    //   'createdAt': DateTime.now().toString()
    // };

     var pet = Pet(name:name, species:species, behaviour:behaviour, age: age, medical_records: md);
      final data = {'title': pet, 'description': pet};
    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
