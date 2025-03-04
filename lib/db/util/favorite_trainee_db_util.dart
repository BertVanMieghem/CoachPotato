import 'package:coach_potato/db/db_provider.dart';
import 'package:coach_potato/db/util/trainee_db_util.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:sqflite/sqlite_api.dart';

class FavoriteTraineeDbUtil {
  static final DatabaseProvider provider = DatabaseProvider.instance;

  static Future<void> addFavorite(int coachId, int traineeId) async {
    final Database db = await provider.database;
    await db.insert(
      'favorite_trainee',
      <String, dynamic>{
        'coach_id': coachId,
        'trainee_id': traineeId,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  static Future<void> removeFavorite(int coachId, int traineeId) async {
    final Database db = await provider.database;
    await db.delete(
      'favorite_trainee',
      where: 'coach_id = ? AND trainee_id = ?',
      whereArgs: <int>[coachId, traineeId],
    );
  }

  static Future<List<Trainee>> getFavoriteTrainees(int coachId) async {
    final Database db = await provider.database;
    final List<Map<String, dynamic>> objects = await db.rawQuery(
      '''
      SELECT t.* FROM trainee t
      JOIN favorite_trainee f ON t.id = f.trainee_id
      WHERE f.coach_id = ?
      ''',
      <int>[coachId],
    );
    return TraineeDbUtil.objectsToTrainees(objects);
  }
}
