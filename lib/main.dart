import 'package:coach_potato/auth/coach_trainee_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coach Potato',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CoachTraineeChoice(),
    );
  }
}
