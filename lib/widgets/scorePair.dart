import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScorePair extends StatefulWidget {
  final List<int> pair;
  final Widget icon; //middle icon
  final bool
      isPair; //true if the user can change both, false if the second is constant
  final void Function(List<int>) onChange;

  const ScorePair({
    Key key,
    this.pair,
    this.isPair = true,
    this.onChange,
    this.icon,
  })  : assert(pair.length == 2),
        super(key: key);

  @override
  _ScorePairState createState() => _ScorePairState();
}

class _ScorePairState extends State<ScorePair> {
  List<TextEditingController> _controllers;

  @override
  void initState() {
    _controllers = [];
    for (int i in Iterable<int>.generate(2)) {
      TextEditingController controller = TextEditingController();
      controller.text = widget.pair[i].toString();
      if (controller.text == '0') controller.text = '';
      controller.addListener(() {
        print(controller.text);
        widget.onChange(getPair());
      });
      _controllers.add(controller);
    }

    if (!widget.isPair) {
      //TODO: disable the textField
    }

    super.initState();
  }

  List<int> getPair() => _controllers
      .map((c) => int.parse((c.text == '') ? '0' : c.text))
      .toList();

  @override
  void dispose() {
    _controllers.forEach((x) => x.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: _controllers[0],
            ),
          ),
        ),
        widget.icon,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: widget.isPair,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              readOnly: !widget.isPair,
              controller: _controllers[1],
            ),
          ),
        ),
      ],
    );
  }
}
