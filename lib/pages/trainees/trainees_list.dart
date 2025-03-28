import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/pages/trainees/trainees_list_tiles.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TraineesList extends ConsumerWidget {
  const TraineesList({required this.trainees, super.key});

  final List<Trainee> trainees;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        if (trainees.length > 10)
          Padding(
            padding: const EdgeInsets.all(defPadding),
            child: TextField(
              decoration: InputDecoration(
                labelText: '${trainees.length} Trainees',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (String value) {
                ref.read(traineeFilterProvider.notifier).state = value;
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: defPadding / 2),
            child: Text(
              'Trainees',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 18,
              ),
            ),
          ),
        Flexible(
          child: TraineesListTiles(trainees: trainees),
        ),
      ],
    );
  }
}
