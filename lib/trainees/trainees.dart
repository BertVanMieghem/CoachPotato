import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/db/util/trainee_db_util.dart';
import 'package:coach_potato/model/trainee.dart';
import 'package:coach_potato/trainees/trainees_list.dart';
import 'package:flutter/material.dart';

class Trainees extends StatefulWidget {
  const Trainees({super.key});

  @override
  State<Trainees> createState() => _TraineesState();
}

class _TraineesState extends State<Trainees> {
  bool _loading = true;
  List<Trainee> _trainees = <Trainee>[];
  String _filter = '';

  @override
  void initState() {
    super.initState();

    Future<void>.delayed(Duration.zero, () async {
      _trainees = await TraineeDbUtil.getAllTrainees();
      setState(() => _loading = false);
    });
  }

  List<Trainee> _filteredTrainees() {
    if (_filter.isEmpty) return _trainees;
    return _trainees.where((Trainee t) =>
    t.firstName?.toLowerCase().contains(_filter.toLowerCase()) == true ||
        t.lastName.toLowerCase().contains(_filter.toLowerCase()) ||
        t.email.toLowerCase().contains(_filter.toLowerCase()),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_trainees.isEmpty) {
      return const Center(child: Text('No trainees found'));
    }

    final int traineeCount = _trainees.length;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          children: <Widget>[
            if (traineeCount > 100)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '$traineeCount Trainees',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() => _filter = value);
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: defPadding / 2),
                child: Text(
                  'Trainees',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 18),
                ),
              ),
            Expanded(
                child: TraineesList(trainees: _filteredTrainees()),
            ),
          ],
        ),
      ),
    );
  }
}
