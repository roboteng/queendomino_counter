import 'package:flutter/material.dart';

class ScoringUnit extends StatefulWidget {
  final Function onChange;

  ScoringUnit({Key key, this.onChange}) : super(key: key);
  @override
  _ScoringUnitState createState() => _ScoringUnitState();
}

class _ScoringUnitState extends State<ScoringUnit> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(
      () {
        {
          if (_controller.text != '') {
            widget.onChange(_controller.text);
          } else {
            widget.onChange('0');
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 96,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          keyboardType: TextInputType.number,
          controller: _controller,
        ),
      ),
    );
  }
}
