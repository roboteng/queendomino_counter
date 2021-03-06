import 'package:flutter/material.dart';
import 'package:queendomino_counter/domain/entities/categories.dart';
import 'package:queendomino_counter/screens/scoreBreakout.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/utils/scoring.dart';

class ScoringUnit extends StatefulWidget {
  final void Function(int) onChange;
  final Category category;
  final int playerId;

  ScoringUnit({Key key, this.onChange, this.category, this.playerId})
      : super(key: key);
  @override
  _ScoringUnitState createState() => _ScoringUnitState();
}

class _ScoringUnitState extends State<ScoringUnit> {
  List<List<int>> scores;
  String label;

  @override
  void initState() {
    if (scores == null)
      scores = [
        [0, getCategoryProperties(widget.category).isSecondSlotEditable ?? 0]
      ];
    super.initState();
    label = subScore(scores, getCategoryProperties(widget.category).calculate)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 96,
        child: OutlinedButton(
          child: Text(label),
          onPressed: () async {
            List<List<int>> results = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return BreakoutScreen(
                  scores: scores,
                  category: widget.category,
                );
              },
            );
            if (results != null) {
              setState(() {
                scores = results;
                int val = subScore(
                  scores,
                  getCategoryProperties(widget.category).calculate,
                );
                widget.onChange(val);
                label = val.toString();
              });
            }
          },
        ),
      ),
    );
  }
}
