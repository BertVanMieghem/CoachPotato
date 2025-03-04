import 'dart:convert';
import 'package:coach_potato/constants/db.dart';
import 'package:coach_potato/faker/faker.dart';
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
      CREATE TABLE coach (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        created_at INT NOT NULL,
        updated_at INT
      );
    ''');

    await db.insert('coach', <String, dynamic>{
      'first_name': 'Den',
      'last_name': 'Dikke',
      'email': 'den.dikke@gmail.com',
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });

    await db.execute('''
      CREATE TABLE trainee (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT,
        last_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT,
        discipline TEXT,
        created_at INT NOT NULL,
        updated_at INT
      );
    ''');

    await db.execute('''
      CREATE TABLE favorite_trainee (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        coach_id INTEGER NOT NULL,
        trainee_id INTEGER NOT NULL,
        created_at INT NOT NULL,
        FOREIGN KEY (coach_id) REFERENCES coach(id) ON DELETE CASCADE,
        FOREIGN KEY (trainee_id) REFERENCES trainee(id) ON DELETE CASCADE,
        UNIQUE(coach_id, trainee_id)
      );
    ''');

    // insert 75 dummy trainees
    for (int i = 0; i < 75; i++) {
      await db.insert('trainee', Faker.getFakeTrainee());
    }

    await db.execute('''
      CREATE TABLE plan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        coach_id INTEGER NOT NULL,
        trainee_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        created_at INT NOT NULL,
        updated_at INT,
        FOREIGN KEY (coach_id) REFERENCES coach(id) ON DELETE CASCADE,
        FOREIGN KEY (trainee_id) REFERENCES trainee(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE plan_exercise (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plan_id INTEGER NOT NULL,
        exercise_id INTEGER NOT NULL,
        sets INTEGER,
        reps INTEGER,
        weight REAL,
        order_index INTEGER,
        FOREIGN KEY (plan_id) REFERENCES plan(id) ON DELETE CASCADE,
        FOREIGN KEY (exercise_id) REFERENCES exercise(id) ON DELETE CASCADE
      )
    ''');

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
