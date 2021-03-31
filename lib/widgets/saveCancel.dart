import 'package:flutter/material.dart';

class SaveCancelOptions<T> extends StatelessWidget {
  final T Function() returnParams;

  const SaveCancelOptions({Key key, this.returnParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: <Widget>[
        SimpleDialogOption(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: Text('Save'),
          onPressed: () {
            Navigator.pop(context, returnParams());
          },
        ),
      ],
    );
  }
}
