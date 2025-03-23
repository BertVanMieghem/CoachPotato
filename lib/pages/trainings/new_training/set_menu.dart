import 'package:coach_potato/constants/ui.dart';
import 'package:flutter/material.dart';

class SetMenu extends StatelessWidget {
  const SetMenu({required this.hasNote, required this.toggleHasNote, required this.removeSet, super.key});
  
  final bool hasNote;
  final Function() toggleHasNote;
  final Function() removeSet;
  
  void handleSelection(String choice) {
    switch (choice) {
      case 'Note':
        toggleHasNote();
        break;
      case 'Remove':
        removeSet();
        break;
      default:
        break;
    }
  }

  IconData getIconData(String choice) {
    switch (choice) {
      case 'Note':
        return hasNote ? Icons.comments_disabled_outlined : Icons.comment_outlined;
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
      icon: Icon(Icons.more_vert, size: 18, color: Theme.of(context).colorScheme.onSurface),
      itemBuilder: (BuildContext context) {
        return <String>{'Note', 'Remove'}.map((String choice) {
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
