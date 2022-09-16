import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../model/simple_model.dart';

//import 'SimpleModel_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE groceries(
      id INTEGER PRIMARY KEY,
      name TEXT,
      description TEXT
    )
''');
  }

  Future<List<SimpleModel>> getSimpleModels() async {
    Database db = await instance.database;
    var groceries = await db.query(
      'groceries',
      orderBy: 'name',
    );

    List<SimpleModel> groceriesList = groceries.isNotEmpty
        ? groceries.map((c) => SimpleModel.fromMap(c)).toList()
        : [];

    return groceriesList;
  }

  Future<int> add(SimpleModel SimpleModel) async {
    Database db = await instance.database;
    return await db.insert('groceries', SimpleModel.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('groceries', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(SimpleModel SimpleModel) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        'UPDATE groceries SET name = ? WHERE id = ${SimpleModel.id}', [
      '${SimpleModel.name}',
    ]);
    // return await db.update('groceries', SimpleModel.toMap(),
    //     where: 'id : ?', whereArgs: [SimpleModel.id]);
  }
}
