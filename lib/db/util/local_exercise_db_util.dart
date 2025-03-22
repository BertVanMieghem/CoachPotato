import 'package:coach_potato/db/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalExerciseDbUtil {
  static final DatabaseProvider provider = DatabaseProvider.instance;

  static Future<List<String>> getAllExerciseNames() async {
    final Database db = await provider.database;
    final List<Map<String, dynamic>> objects = await db.query('exercise', columns: <String>['name'], orderBy: 'name');
    return objects.map((Map<String, dynamic> object) => object['name'] as String).toList();
  }
}