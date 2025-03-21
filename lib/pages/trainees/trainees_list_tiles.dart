import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:coach_potato/model/trainee.dart';

class TraineesListTiles extends ConsumerWidget {
  const TraineesListTiles({required this.trainees, super.key});

  final List<Trainee> trainees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? selectedTraineeId = ref.watch(traineeIdProvider);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: trainees.length,
      itemBuilder: (BuildContext context, int index) {
        final Trainee trainee = trainees[index];
        final bool isSelected = selectedTraineeId == trainee.id;

        return ListTile(
          leading: CircleAvatar(
            child: Text(trainee.lastName[0].toUpperCase()),
          ),
          title: Text('${trainee.firstName ?? ''} ${trainee.lastName}'),
          subtitle: Text(trainee.email),
          selected: isSelected,
          selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
          selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
          tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
          onTap: () {
            ref.read(traineeIdProvider.notifier).state = trainee.id;
          },
        );
      },
    );
  }
}
