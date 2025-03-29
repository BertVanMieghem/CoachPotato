import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/pages/trainees/trainees_list.dart';
import 'package:coach_potato/pages/trainings/new_training/new_training_fields.dart';
import 'package:coach_potato/pages/trainings/training_list/training_list.dart';
import 'package:coach_potato/provider/trainee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Trainings extends ConsumerStatefulWidget {
  const Trainings({super.key});

  @override
  ConsumerState<Trainings> createState() => _TrainingsState();
}

class _TrainingsState extends ConsumerState<Trainings> {

  bool _showNewTrainingFields = false;

  List<Trainee> _filteredTrainees(List<Trainee> trainees, String filter) {
    if (filter.isEmpty) return trainees;
    return trainees.where((Trainee t) {
      return t.firstName?.toLowerCase().contains(filter.toLowerCase()) == true ||
          t.lastName.toLowerCase().contains(filter.toLowerCase()) ||
          t.email.toLowerCase().contains(filter.toLowerCase());
    }).toList();
  }

  Widget _addTrainingButton(BuildContext context, String traineeId) {
    return SizedBox(
      height: defPadding * 4,
      child: ElevatedButton(
        onPressed: () => setState(() => _showNewTrainingFields = true),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defPadding),
          ),
        ),
        child: Row(
          spacing: defPadding / 2,
          children: <Widget>[
            Icon(Icons.add, color: Theme.of(context).colorScheme.onTertiaryContainer),
            const Text('Add training'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Trainee>> trainees = ref.watch(traineesProvider);
    final String filter = ref.watch(traineeFilterProvider);
    final String? traineeId = ref.watch(traineeIdProvider);

    return trainees.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object e, StackTrace s) => const Center(child: Text('Failed to load trainees')),
      data: (List<Trainee> trainees) {
        if (trainees.isEmpty) {
          return const Center(child: Text('No trainees found'));
        }

        return Row(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TraineesList(trainees: _filteredTrainees(trainees, filter)),
            ),

            if (traineeId != null)
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - traineeListWidth),
                child: Padding(
                  padding: const EdgeInsets.all(defPadding),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: defPadding,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _addTrainingButton(context, traineeId),

                          if (_showNewTrainingFields)
                              NewTrainingFields(traineeId: traineeId, onFinished: () => setState(() =>_showNewTrainingFields = false)),

                          TrainingList(traineeId: traineeId),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
