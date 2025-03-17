import 'dart:convert';
import 'package:coach_potato/constants/db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = dbPathWeb;
    } else {
      final String databasesPath = await getDatabasesPath();
      path = join(databasesPath, dbPath);
    }

    return await openDatabase(
      path,
      version: dbVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercise (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        force TEXT,
        level TEXT,
        mechanic TEXT,
        equipment TEXT,
        primaryMuscles TEXT,
        secondaryMuscles TEXT,
        instructions TEXT,
        category TEXT,
        images TEXT
      )
    ''');

    final String dataString = await rootBundle.loadString('assets/exercises.json');
    final List<dynamic> exercises = json.decode(dataString);

    for (dynamic exercise in exercises) {
      exercise['primaryMuscles'] = json.encode(exercise['primaryMuscles']);
      exercise['secondaryMuscles'] = json.encode(exercise['secondaryMuscles']);
      exercise['instructions'] = json.encode(exercise['instructions']);
      exercise['images'] = json.encode(exercise['images']);

      await db.insert('exercise', Map<String, dynamic>.from(exercise));
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // ...
    }
  }
}
