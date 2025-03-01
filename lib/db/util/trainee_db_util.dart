import 'package:coach_potato/db/db_provider.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:sqflite/sqflite.dart';

class TraineeDbUtil {
  static final DatabaseProvider provider = DatabaseProvider.instance;

  static Future<List<Trainee>> getAllTrainees() async {
    final Database db = await provider.database;
    final List<Map<String, dynamic>> objects = await db.query('trainee');
    return objectsToTrainees(objects);
  }

  /// AUXILIARY
  static List<Trainee> objectsToTrainees(List<Map<String, dynamic>> objects) {
    return objects.map((Map<String, dynamic> e) => Trainee.fromMap(e)).toList();
  }
}