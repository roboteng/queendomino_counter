import 'package:flutter/material.dart';
import 'package:queendomino_counter/utils/range.dart';
import 'package:queendomino_counter/widgets/saveCancel.dart';
import 'package:queendomino_counter/widgets/scorePair.dart';

class BreakoutScreen extends StatefulWidget {
  final List<List<int>> scores;

  BreakoutScreen({Key key, this.scores}) : super(key: key);

  @override
  _BreakoutScreenState createState() => _BreakoutScreenState();
}

class _BreakoutScreenState extends State<BreakoutScreen> {
  List<List<int>> scores;

  @override
  void initState() {
    super.initState();
    scores = widget.scores;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Update Score'),
      children: <Widget>[
        Column(children: [
          for (int i in range(scores.length - 1))
            ScorePair(
              pair: scores[i],
              onChange: (newPair) {
                scores[i] = newPair;
              },
            ),
        ]),
        SaveCancelOptions(returnParams: scores),
      ],
    );
  }
}

//Row(
//mainAxisAlignment: MainAxisAlignment.end,
//children: <Widget>[
//IconButton(
//icon: Icon(Icons.add),
//onPressed: () {
//setState(() {
//scores.add([0, 0]);
//});
//},
//),
//],
//);
