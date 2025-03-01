import 'package:coach_potato/auth/auth.dart';
import 'package:coach_potato/home/home.dart';
import 'package:coach_potato/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Coach Potato',
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      routes: <String, WidgetBuilder>{
        '/auth': (BuildContext context) => AuthPage(),
        '/home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      themeMode: ref.watch(themeProvider),
      home: SafeArea(
        child: const AuthPage(),
      ),
    );
  }
}
