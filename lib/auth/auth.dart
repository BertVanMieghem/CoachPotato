import 'package:coach_potato/auth/sign_in_code.dart';
import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/provider/coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                  'Coach Potato',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 42),
                ),
                const SizedBox(height: 3 * defPadding),
                TextField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.auth_email,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: defPadding),
                TextField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.auth_password,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: defPadding),
                ElevatedButton(
                  onPressed: () {
                    ref.read(coachProvider.notifier).state = 1;
                    context.go('/dashboard');
                  },
                  child: Text(AppLocalizations.of(context)!.auth_sign_in),
                ),
                const SizedBox(height: defPadding / 2),
                TextButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.auth_create_account),
                ),

                Divider(
                  height: 2 * defPadding,
                  thickness: 1,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<SignInCode>(builder: (BuildContext context) => const SignInCode()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: defPadding / 2,
                    children: <Widget>[
                      Icon(Icons.pin_outlined, color: Colors.white),
                      Text(AppLocalizations.of(context)!.auth_code),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
