import 'package:coach_potato/pages/home/header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(
            child: ClipRRect(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

