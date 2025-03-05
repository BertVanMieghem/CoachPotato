import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:coach_potato/trainees/trainees_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Trainees extends ConsumerWidget {
  const Trainees({this.child, super.key});

  final Widget? child;

  List<Trainee> _filteredTrainees(List<Trainee> trainees, String filter) {
    if (filter.isEmpty) return trainees;
    return trainees.where((Trainee t) {
      return t.firstName?.toLowerCase().contains(filter.toLowerCase()) == true ||
          t.lastName.toLowerCase().contains(filter.toLowerCase()) ||
          t.email.toLowerCase().contains(filter.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Trainee>> trainees = ref.watch(traineesProvider);
    final String filter = ref.watch(traineeFilterProvider);

    return trainees.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, StackTrace s) => const Center(child: Text('Failed to load trainees')),
      data: (List<Trainee> trainees) {
        if (trainees.isEmpty) {
          return const Center(child: Text('No trainees found'));
        }

        final List<Trainee> filteredTrainees = _filteredTrainees(trainees, filter);

        return Row(
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: <Widget>[
                  if (trainees.length > 10)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                    child: TraineesList(trainees: filteredTrainees),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}