import 'package:flutter/material.dart';

class ScorePair extends StatefulWidget {
  final List<int> pair;
  final bool isMultiply; //true if multiply, false if divide
  final bool
      isPair; //true if the user can change both, false if the second is constant
  final void Function(List<int>) onChange;

  const ScorePair({
    Key key,
    this.pair,
    this.isMultiply = true,
    this.isPair = true,
    this.onChange,
  })  : assert(pair.length == 2),
        super(key: key);

  @override
  _ScorePairState createState() => _ScorePairState();
}

class _ScorePairState extends State<ScorePair> {
  TextEditingController _c1;
  TextEditingController _c2;

  @override
  void initState() {
    for (TextEditingController controller in [_c1, _c2]) {
      controller = TextEditingController();
      controller.text = widget.pair[0].toString();
      controller.addListener(() {
        widget.onChange(getPair());
      });
    }

    if (!widget.isPair) {
      //TODO: disable the textField
    }

    super.initState();
  }

  List<int> getPair() {
    return [
      int.parse(_c1.text),
      int.parse(_c2.text),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _c1,
          ),
        ),
        Icon(widget.isMultiply ? Icons.close : Icons.navigate_before),
        Expanded(
          child: TextField(
            readOnly: !widget.isPair,
            controller: _c2,
          ),
        ),
      ],
    );
  }
}
