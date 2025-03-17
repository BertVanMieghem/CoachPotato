import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardFavorites extends ConsumerWidget {
  const DashboardFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Trainee>> favoriteTrainees = ref.watch(favoriteTraineesProvider);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            width: double.infinity,
            padding: EdgeInsets.all(defPadding),
            child: Text(
              'Favorites',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: favoriteTrainees.when(
              data: (List<Trainee> trainees) {
                if (trainees.isEmpty) {
                  return const Center(child: Text('No favorite trainees yet.'));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: defPadding,
                    mainAxisSpacing: defPadding,
                  ),
                  itemCount: trainees.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Trainee trainee = trainees[index];

                    return Padding(
                      padding: const EdgeInsets.all(defPadding),
                      child: GridTile(
                        footer: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trainee.firstName!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.person_outline, size: 100, color: Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object error, StackTrace? stackTrace) =>
                  Center(child: Text('Failed to load favorite trainees: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
