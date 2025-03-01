import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final StateNotifierProvider<ThemeNotifier, ThemeMode> themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((Ref ref) {
  return ThemeNotifier();
});