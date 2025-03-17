import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _signIn() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final AuthService authService = ref.read(authServiceProvider);
    final User? user = await authService.signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user != null) {
      print(getUserData());
      context.go('/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String? uid = auth.currentUser?.uid;
    if (uid == null) return null;

    DocumentSnapshot<Map<String, dynamic>?> userDoc = await firestore.collection('users').doc(uid).get();
    return userDoc.data();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.auth_email,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: defPadding),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.auth_password,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onSubmitted: (String _) => _signIn(),
                ),
                const SizedBox(height: defPadding),
                ElevatedButton(
                  onPressed: _signIn,
                  child: _isLoading
                      ? SizedBox(
                          width: defPadding,
                          height: defPadding,
                          child: const CircularProgressIndicator(),
                        )
                      : Text(AppLocalizations.of(context)!.auth_sign_in),
                ),
                const SizedBox(height: defPadding / 2),
                TextButton(
                  onPressed: () => context.go('/signup'),
                  child: Text(AppLocalizations.of(context)!.auth_create_account),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
