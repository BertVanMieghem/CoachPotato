import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:coach_potato/model/trainee.dart';

class TraineesList extends ConsumerWidget {
  const TraineesList({required this.trainees, super.key});

  final List<Trainee> trainees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTrainees = ref.watch(favoriteTraineesProvider);
    final toggleFavorite = ref.read(favoriteToggleProvider);

    return ListView.builder(
      itemCount: trainees.length,
      itemBuilder: (BuildContext context, int index) {
        final Trainee trainee = trainees[index];
        final bool isFavorite = favoriteTrainees.maybeWhen(
          data: (List<Trainee> favorites) => favorites.any((t) => t.id == trainee.id),
          orElse: () => false,
        );

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defPadding / 2),
          ),
          margin: const EdgeInsets.symmetric(vertical: defPadding / 2, horizontal: defPadding),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(trainee.lastName[0].toUpperCase()),
            ),
            title: Text('${trainee.firstName ?? ''} ${trainee.lastName}'),
            subtitle: Text(trainee.email),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.yellow : Colors.grey,
              ),
              onPressed: () => toggleFavorite(trainee),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defPadding / 2),
            ),
            onTap: () {
              // Handle tap
            },
          ),
        );
      },
    );
  }
}
