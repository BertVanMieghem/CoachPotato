import 'package:coach_potato/db/util/favorite_trainee_db_util.dart';
import 'package:coach_potato/db/util/trainee_db_util.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/provider/coach_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to fetch and hold the list of trainees
final FutureProvider<List<Trainee>> traineesProvider = FutureProvider<List<Trainee>>((Ref ref) async {
  return await TraineeDbUtil.getAllTrainees();
});

/// Provider for the filter input
final StateProvider<String> traineeFilterProvider = StateProvider<String>((Ref ref) => '');

/// Provider for currently selected trainee
final StateProvider<String?> traineeIdProvider = StateProvider<String?>((Ref ref) => null);

/// Provider to fetch the currently selected trainee
final FutureProviderFamily<Trainee?, String> traineeProvider = FutureProvider.family<Trainee?, String>((Ref ref, String id) async {
  return await TraineeDbUtil.getTraineeById(id);
});

/// Provider to fetch favorite trainees for the currently logged-in coach
final FutureProvider<List<Trainee>> favoriteTraineesProvider = FutureProvider<List<Trainee>>((Ref ref) async {
  return FavoriteTraineeDbUtil.getFavoriteTrainees();
});

/// Provider to toggle favorite status
final favoriteToggleProvider = Provider((Ref ref) {
  return (Trainee trainee) async {
    print('Toggling favorite for ${trainee.id}');
    final String coachId = CoachProvider.getCoachUid();

    print('coachId: $coachId');
    final List<Trainee> favorites = await ref.read(favoriteTraineesProvider.future);
    final bool isFavorite = favorites.any((Trainee t) => t.id == trainee.id);

    if (isFavorite) {
      await FavoriteTraineeDbUtil.removeFavoriteTrainee(trainee.id!);
    } else {
      await FavoriteTraineeDbUtil.addFavoriteTrainee(trainee.id!);
    }

    ref.invalidate(favoriteTraineesProvider);
  };
});