import 'package:flutter/material.dart';
import 'package:queendomino_counter/screens/scoreBreakout.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/utils/scoring.dart';

class ScoringUnit extends StatefulWidget {
  final void Function(int) onChange;
  final String title;
  final int playerId;

  ScoringUnit({Key key, this.onChange, this.title, this.playerId})
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
        [0, getCategoryProperties(widget.title)[SECOND] ?? 0]
      ];
    super.initState();
    label =
        subScore(scores, getCategoryProperties(widget.title)[FUNC]).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 96,
        child: RaisedButton(
          child: Text(label),
          onPressed: () async {
            List<List<int>> results = await showDialog(
              context: context,
              child: BreakoutScreen(
                scores: scores,
                title: widget.title,
              ),
            );
            if (results != null) {
              setState(() {
                scores = results;
                int val =
                    subScore(scores, getCategoryProperties(widget.title)[FUNC]);
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
