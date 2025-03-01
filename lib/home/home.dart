import 'package:coach_potato/home/side_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[

          // Sidebar Menu
          SideMenu(),

          // Main Content
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
