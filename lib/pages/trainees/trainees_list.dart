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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: trainees.length,
      itemBuilder: (BuildContext context, int index) {
        final Trainee trainee = trainees[index];

        return ListTile(
          leading: CircleAvatar(
            child: Text(trainee.lastName[0].toUpperCase()),
          ),
          title: Text('${trainee.firstName ?? ''} ${trainee.lastName}'),
          subtitle: Text(trainee.email),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defPadding / 2),
          ),
          onTap: () {
            ref.read(traineeIdProvider.notifier).state = trainee.id;
          },
        );
      },
    );
  }
}
