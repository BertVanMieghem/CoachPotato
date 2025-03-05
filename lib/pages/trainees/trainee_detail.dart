import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TraineeDetail extends ConsumerWidget {
  const TraineeDetail({required this.id, super.key});

  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Trainee?> trainee = ref.watch(traineeProvider(id));
    final favoriteTrainees = ref.watch(favoriteTraineesProvider);
    final toggleFavorite = ref.read(favoriteToggleProvider);

    return trainee.when(
      data: (Trainee? t) {
        if (t == null) {
          return const Center(child: Text('Trainee not found'));
        }

        final bool isFavorite = favoriteTrainees.maybeWhen(
          data: (List<Trainee> favorites) => favorites.any((Trainee f) => f.id == t.id),
          orElse: () => false,
        );

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(defPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    t.lastName[0].toUpperCase(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(width: defPadding * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '${t.firstName} ${t.lastName}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(width: defPadding),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.yellow : Colors.grey,
                          ),
                          onPressed: () => toggleFavorite(t),
                        ),
                      ],
                    ),
                    Text(
                      t.discipline!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(width: defPadding * 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: defPadding / 2,
                  children: <Widget>[
                    SizedBox(height: defPadding),
                    Text(t.email, style: Theme.of(context).textTheme.bodyMedium),
                    Text(t.phone ?? '', style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      'Created ${DateFormat('d MMMM yyyy HH:mm').format(DateTime.fromMillisecondsSinceEpoch(t.createdAt))}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, _) => Center(child: Text('Failed to load trainee: $error')),
    );
  }
}