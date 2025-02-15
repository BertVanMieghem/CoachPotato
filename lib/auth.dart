import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Text('Coach Potato'),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Sign In'),
              ),
            ],
          )
        )
      )
    );
  }
}
