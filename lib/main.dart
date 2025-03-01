import 'package:coach_potato/provider/theme_provider.dart';
import 'package:coach_potato/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(

      title: 'Coach Potato',
      debugShowCheckedModeBanner: false,

      /// ROUTING
      routerConfig: ref.watch(routerProvider),

      /// THEME
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      themeMode: ref.watch(themeProvider),

      /// LOCALIZATION
      localizationsDelegates: <LocalizationsDelegate<AppLocalizations>>[
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
