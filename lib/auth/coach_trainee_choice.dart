import 'package:flutter/material.dart';

import '../constants/ui.dart';

class CoachTraineeChoice extends StatelessWidget {
  const CoachTraineeChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(2 * defPadding),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Are you a coach or a trainee?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3 * defPadding),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Coach'),
                  ),
                  const SizedBox(height: defPadding),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Trainee'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
