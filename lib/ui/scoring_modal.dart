import 'package:flutter/material.dart';
import 'package:queendomino_counter/domain/entities/categories.dart';
import 'package:queendomino_counter/domain/entities/player.dart';

class ScoringModal extends StatefulWidget {
  final Category category;
  final Player player;
  final int initialValue;

  const ScoringModal({Key key, this.category, this.player, this.initialValue})
      : super(key: key);
  @override
  _ScoringModalState createState() => _ScoringModalState();
}

class _ScoringModalState extends State<ScoringModal> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    controller.text = widget.initialValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('${widget.category.shortString} for ${widget.player.name}'),
      contentPadding: EdgeInsets.all(8),
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        Wrap(children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
              onPressed: () =>
                  Navigator.pop(context, int.parse(controller.text)),
              child: Text('Save')),
        ]),
      ],
    );
  }
}
