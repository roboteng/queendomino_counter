import 'package:flutter/material.dart';
import 'package:queendomino_counter/screens/scoreBreakout.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/utils/scoring.dart';

class ScoringUnit extends StatefulWidget {
  final Function onChange;
  final String title;

  ScoringUnit({Key key, this.onChange, this.title}) : super(key: key);
  @override
  _ScoringUnitState createState() => _ScoringUnitState();
}

class _ScoringUnitState extends State<ScoringUnit> {
  List<List<int>> scores;

  @override
  void initState() {
    if (scores == null)
      scores = [
        [0, 1]
      ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 96,
        child: RaisedButton(
          child: Text(
              subScore(scores, getCategoryProperties(widget.title)[FUNC])
                  .toString()),
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
              });
            }
          },
        ),
      ),
    );
  }
}
