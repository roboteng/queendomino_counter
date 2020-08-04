import 'package:flutter/material.dart';
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
  List<bool> isVisible;

  List<List<int>> getVisible() {
    debugPrint('get visible');
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
  Widget build(BuildContext context) {
    assert(scores.length == isVisible.length);
    return SimpleDialog(
      title: Text('Update Score'),
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: isVisible.length + 1,
          itemBuilder: (context, i) {
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
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        scores.add([0, 1]);
                        isVisible.add(true);
                      });
                    },
                  ),
                ],
              );
            }
          },
        ),
        SaveCancelOptions(returnParams: getVisible),
      ],
    );
  }
}
