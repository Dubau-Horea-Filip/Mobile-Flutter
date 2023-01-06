// ignore_for_file: file_names, depend_on_referenced_packages, constant_identifier_names

import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import '../models/Pet_model.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _DBname = "Pets.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _DBname),
        onCreate: (db, version) async => await db.execute("""CREATE TABLE Pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        age INTEGER,
        species TEXT,
        behaviour TEXT,
        MD TEXT
      );
      """), version: _version);
  }

  //static Future<int> addPet(Pet pet) async {
  static addPet(Pet pet) async {
    //insert api call

    var response =
        await http.post(Uri.parse('http://10.0.2.2:9191/addPet'), body: {
      "name": pet.name,
      "age": pet.age.toString(),
      "species": pet.species,
      "behaviour": pet.behaviour,
      "md": pet.md
    });

    print(response);

    // final db = await _getDB();
    // return await db.insert("Pets", pet.toJson(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //static Future<int> updatePet(Pet pet) async {
  static void updatePet(Pet pet) async {
    var response =
        await http.put(Uri.parse('http://10.0.2.2:9191/updatePet'), body: {
      "id": pet.id.toString(),
      "name": pet.name,
      "age": pet.age.toString(),
      "species": pet.species,
      "behaviour": pet.behaviour,
      "md": pet.md
    });

    print(response);

    // final db = await _getDB();
    // return await db.update("Pets", pet.toJson(),
    //     where: 'id = ?',
    //     whereArgs: [pet.id],
    //     conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static void deletePet(Pet pet) async {
    var response =
        await http.delete(Uri.parse('http://10.0.2.2:9191/delete/${pet.id}'));

    print(response);

    // final db = await _getDB();
    // return await db.delete("Pets", where: 'id = ?', whereArgs: [pet.id]);
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
