import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Pet_model.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _DBname = "Pets.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _DBname),
        onCreate: (db, version) async => await db.execute("""CREATE TABLE pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        age INTEGER,
        species TEXT,
        behaviour TEXT,
        MD TEXT
      );
      """), version: _version);
  }

  static Future<int> addPet(Pet pet) async {
    final db = await _getDB();
    return await db.insert("Pets", pet.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updatePet(Pet pet) async {
    final db = await _getDB();
    return await db.update("Pets", pet.toJson(),
        where: 'id = ?',
        whereArgs: [pet.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deletePet(Pet pet) async {
    final db = await _getDB();
    return await db.delete("Pets", where: 'id = ?', whereArgs: [pet.id]);
  }

  static Future<List<Pet>?> getPets() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Pets");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Pet.fromJson(maps[index]));
  }
}
