import 'package:flutter/material.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/widgets/saveCancel.dart';
import 'package:queendomino_counter/widgets/scorePair.dart';

class BreakoutScreen extends StatefulWidget {
  final List<List<int>> scores;
  final String title;

  BreakoutScreen({Key key, this.scores, this.title}) : super(key: key);

  @override
  _BreakoutScreenState createState() => _BreakoutScreenState();
}

class _BreakoutScreenState extends State<BreakoutScreen> {
  List<List<int>> scores;
  List<bool> isVisible;

  List<List<int>> getVisible() {
    List<List<int>> values = [];
    for (int i in Iterable.generate(scores.length)) {
      if (isVisible[i]) {
        values.add(scores[i]);
      }
    }
    return values;
  }

  @override
  void initState() {
    super.initState();
    scores = widget.scores;
    isVisible = List.filled(scores.length, true, growable: true);
  }

  @override
  void dispose() {
    debugPrint('dispose');

    super.dispose();
  }

  Widget columnChildren(BuildContext context, int i) {
    var properties = getCategoryProperties(widget.title);

    if (i < isVisible.length) {
      if (isVisible[i]) {
        return Row(
          children: <Widget>[
            Expanded(
              child: ScorePair(
                pair: scores[i],
                onChange: (items) {
                  scores[i] = items;
                },
                icon: properties[ICON],
                isPair: properties[EDITABLE],
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  isVisible[i] = false;
                });
              },
            ),
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                scores
                    .add([0, getCategoryProperties(widget.title)[SECOND] ?? 0]);
                isVisible.add(true);
              });
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(scores.length == isVisible.length);
    return SimpleDialog(
      title: Text(widget.title ?? 'Update Score'),
      children: <Widget>[
        Column(
          children: <Widget>[
            for (int i in Iterable.generate(isVisible.length + 1))
              columnChildren(context, i)
          ],
        ),
        SaveCancelOptions(returnParams: getVisible),
      ],
    );
  }
}
