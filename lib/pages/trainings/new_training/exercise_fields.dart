import 'package:coach_potato/pages/trainings/new_training/exercise_menu.dart';
import 'package:coach_potato/pages/trainings/new_training/set_menu.dart';
import 'package:flutter/material.dart';
import 'package:coach_potato/constants/ui.dart';
import 'package:coach_potato/pages/trainings/new_training/exercise_autocomplete_field.dart';

class ExerciseFields extends StatefulWidget {
  const ExerciseFields({required this.onRemove, super.key});

  final VoidCallback onRemove;

  @override
  ExerciseFieldsState createState() => ExerciseFieldsState();
}

class ExerciseFieldsState extends State<ExerciseFields> {
  final TextEditingController _nameController = TextEditingController();
  final List<Map<String, TextEditingController>> _setControllers = <Map<String, TextEditingController>>[];
  final List<bool> _hasNoteList = <bool>[]; // List to keep track of which set has a note

  @override
  void initState() {
    super.initState();
    _addSet();
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (Map<String, TextEditingController> set in _setControllers) {
      set['reps']?.dispose();
      set['weight']?.dispose();
      set['note']?.dispose();
    }
    super.dispose();
  }

  void _addSet() {
    setState(() {
      _setControllers.add(<String, TextEditingController>{
        'reps': TextEditingController(),
        'weight': TextEditingController(),
        'note': TextEditingController(),
      });
      _hasNoteList.add(false);
    });
  }

  void _removeSet(int index) {
    if (index >= 0) {
      setState(() {
        final Map<String, TextEditingController> removed = _setControllers.removeAt(index);
        removed['reps']?.dispose();
        removed['weight']?.dispose();
        removed['note']?.dispose();
        _hasNoteList.removeAt(index);
      });
    }
  }

  /// Returns the current data in this widget as a map.
  /// For example:
  /// {
  ///   'name': 'Squat',
  ///   'sets': [
  ///     {'reps': 5, 'weight': 50.0},
  ///     {'reps': 4, 'weight': 70.0},
  ///   ]
  /// }
  Map<String, dynamic> getData() {
    List<Map<String, dynamic>> sets = <Map<String, dynamic>>[];
    for (final (int index, Map<String, TextEditingController> set) in _setControllers.indexed) {
      sets.add(
        <String, dynamic>{
          'reps': int.tryParse(set['reps']!.text.trim()) ?? 0,
          'weight': double.tryParse(set['weight']!.text.trim()) ?? 0.0,
          'note': _hasNoteList[index] ? set['note']!.text.trim() : null,
        },
      );
    }

    return <String, dynamic>{
      'name': _nameController.text.trim(),
      'sets': sets,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: defPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(defPadding, 0, defPadding, defPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: defPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: defPadding * 3),
                            child: ExerciseAutocompleteField(
                              controller: _nameController,
                            ),
                          ),
                          Text('Sets:'),
                          IconButton(
                            icon: const Icon(Icons.arrow_left),
                            onPressed: () => _removeSet(_setControllers.length - 1),
                          ),
                          Text('${_setControllers.length}'),
                          IconButton(
                            icon: const Icon(Icons.arrow_right),
                            onPressed: _addSet,
                          ),
                        ],
                      ),
                    ),
                    ExerciseMenu(removeExercise: widget.onRemove),
                  ],
                ),

                const SizedBox(height: defPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Padding>.generate(_setControllers.length, (int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: defPadding,
                        children: <Widget>[
                          Text('Set ${index + 1}', style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _setControllers[index]['weight'],
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Weight',
                                filled: true,
                                isDense: true,
                                fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(defPadding / 2),
                              ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(defPadding / 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(defPadding / 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: _setControllers[index]['reps'],
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Reps',
                                filled: true,
                                isDense: true,
                                fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(defPadding / 2),
                              ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(defPadding / 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(defPadding / 2),
                                ),
                              ),
                            ),
                          ),
                          if (_hasNoteList[index])
                            Expanded(
                              child: TextField(
                                controller: _setControllers[index]['notes'],
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'Note',
                                  filled: true,
                                  isDense: true,
                                  fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(defPadding / 2),
                                ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(defPadding / 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(defPadding / 2),
                                  ),
                                ),
                              ),
                            ),
                          SetMenu(
                            hasNote: _hasNoteList[index],
                            toggleHasNote: () => setState(() => _hasNoteList[index] = !_hasNoteList[index]),
                            removeSet: () => _removeSet(index),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _addSet,
                    child: const Text('+ Add set'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
