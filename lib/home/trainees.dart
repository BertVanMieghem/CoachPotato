import 'package:coach_potato/db/util/trainee_db_util.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:flutter/material.dart';

class Trainees extends StatefulWidget {
  const Trainees({super.key});

  @override
  State<Trainees> createState() => _TraineesState();
}

class _TraineesState extends State<Trainees> {

  bool _loading = true;
  List<Trainee> _trainees = <Trainee>[];

  @override
  void initState() {
    super.initState();

    Future<void>.delayed(Duration.zero, () async {
      _trainees = await TraineeDbUtil.getAllTrainees();
      setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_trainees.isEmpty) {
      return const Center(child: Text('No trainees found'));
    }

    return ListView.builder(
      itemCount: _trainees.length,
      itemBuilder: (BuildContext context, int index) {
        final Trainee trainee = _trainees[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(trainee.lastName[0].toUpperCase()),
            ),
            title: Text('${trainee.firstName ?? ''} ${trainee.lastName}'),
            subtitle: Text(trainee.email),
            trailing: Text(trainee.discipline ?? ''),
            onTap: () {
              // Handle tap
            },
          ),
        );
      },
    );
  }
}

