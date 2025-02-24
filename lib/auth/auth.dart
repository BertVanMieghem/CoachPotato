import 'package:coach_potato/auth/sign_in_code.dart';
import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

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
                    'Coach Potato',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3 * defPadding),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: defPadding),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: defPadding),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign in'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Create account'),
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
                      backgroundColor: Colors.deepPurple.shade400,
                      foregroundColor: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: defPadding / 2,
                      children: <Widget>[
                        Icon(Icons.pin_outlined, color: Colors.white),
                        Text('Sign in via code'),
                      ],
                    ),
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
