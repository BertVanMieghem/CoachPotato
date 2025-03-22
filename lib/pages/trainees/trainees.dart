import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/pages/trainees/add_trainee_dialog.dart';
import 'package:coach_potato/pages/trainees/trainee_detail.dart';
import 'package:coach_potato/pages/trainees/trainees_list.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Trainees extends ConsumerWidget {
  const Trainees({super.key});

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
    final String? traineeId = ref.watch(traineeIdProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (BuildContext context) => AddTraineeDialog()),
        child: const Icon(Icons.add),
      ),
      body: trainees.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, StackTrace s) => const Center(child: Text('Failed to load trainees')),
        data: (List<Trainee> trainees) {
          if (trainees.isEmpty) {
            return const Center(child: Text('No trainees found'));
          }

          return Row(
            children: <Widget>[
              Container(
                constraints: const BoxConstraints(maxWidth: traineeListWidth),
                child: TraineesList(trainees: _filteredTrainees(trainees, filter)),
              ),

              if (traineeId != null)
                TraineeDetail(id: traineeId),
            ],
          );
        },
      ),
    );
  }
}
