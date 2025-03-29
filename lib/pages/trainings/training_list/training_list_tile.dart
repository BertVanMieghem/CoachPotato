import 'package:coach_potato/model/training.dart';
import 'package:coach_potato/pages/trainings/training_list/collapsed_week_trainings.dart';
import 'package:coach_potato/pages/trainings/training_list/expanded_week_trainings.dart';
import 'package:flutter/material.dart';

class TrainingListTile extends StatefulWidget {
  const TrainingListTile({required this.week, required this.trainings, super.key});

  final int week;
  final List<Training> trainings;

  @override
  TrainingListTileState createState() => TrainingListTileState();
}

class TrainingListTileState extends State<TrainingListTile> {

  final GlobalKey _listKey = GlobalKey();
  double _listViewHeight = 0;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _updateListViewHeight();
  }
  @override
  void didUpdateWidget(covariant TrainingListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trainings != widget.trainings) {
      _updateListViewHeight();
    }
  }

  void _updateListViewHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox = _listKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && mounted) {
        setState(() {
          _listViewHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() => _isExpanded = !_isExpanded);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'W${widget.week}',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            if (widget.week != 1)
              Flexible(
                child: Container(
                  height: _isExpanded ? _listViewHeight : 50,
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),

        _isExpanded
          ? ExpandedWeekTrainings(listKey: _listKey, trainings: widget.trainings)
          : CollapsedWeekTrainings(numberOfTrainings: widget.trainings.length, onClick: () => setState(() => _isExpanded = !_isExpanded)),
      ],
    );
  }
}
