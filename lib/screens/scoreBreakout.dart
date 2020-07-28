import 'package:flutter/material.dart';
import 'package:queendomino_counter/widgets/saveCancel.dart';

class BreakoutScreen extends StatefulWidget {
  final List<List<int>> scores;

  BreakoutScreen({Key key, this.scores}) : super(key: key);

  @override
  _BreakoutScreenState createState() => _BreakoutScreenState();
}

class _BreakoutScreenState extends State<BreakoutScreen> {
  List<List<int>> scores;
  List<List<TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    scores = widget.scores;
    _controllers = [];
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Update Score'),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    scores[0][0] = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Icon(Icons.crop_square),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    scores[0][1] = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
        SaveCancelOptions(returnParams: scores),
      ],
    );
  }
}
