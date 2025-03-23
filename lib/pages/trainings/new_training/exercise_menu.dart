import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class ExerciseMenu extends StatelessWidget {
  const ExerciseMenu({required this.removeExercise, super.key});

  final Function() removeExercise;

  void handleSelection(String choice) {
    switch (choice) {
      case 'Remove':
        removeExercise();
        break;
      default:
        break;
    }
  }

  IconData getIconData(String choice) {
    switch (choice) {
      case 'Remove':
        return Icons.delete_outline;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: handleSelection,
      icon: Icon(Icons.more_vert, size: 20, color: Theme.of(context).colorScheme.onSurface),
      itemBuilder: (BuildContext context) {
        return <String>{'Remove'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            height: defPadding * 3,
            child: Row(
              spacing: defPadding / 2,
              children: <Widget>[
                Icon(getIconData(choice), size: 14, color: Theme.of(context).colorScheme.onSurface,),
                Text(choice),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
