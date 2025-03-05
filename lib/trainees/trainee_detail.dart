import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TraineeDetail extends ConsumerWidget {
  const TraineeDetail({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Trainee?> trainee = ref.watch(traineeProvider(id));

    return trainee.when(
      data: (Trainee? t) {
        if (t == null) {
          return const Center(child: Text('Trainee not found'));
        }

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${t.firstName} ${t.lastName}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text('Email: ${t.email}'),
              if (t.phone != null) Text('Phone: ${t.phone}'),
              if (t.discipline != null) Text('Discipline: ${t.discipline}'),
              Text('Created at: ${DateTime.fromMillisecondsSinceEpoch(t.createdAt).toLocal()}'),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace? stackTrace) => Center(
        child: Text('Failed to load trainee: $error'),
      ),
    );
  }
}