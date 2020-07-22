import 'package:flutter/material.dart';

class SettingsModal extends StatefulWidget {
  final List<String> players;

  const SettingsModal({Key key, this.players}) : super(key: key);

  @override
  _SettingsModalState createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  List<String> players;

  @override
  void initState() {
    players = widget.players;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Modal Content'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedList(
              shrinkWrap: true,
              initialItemCount: players.length + 1,
              itemBuilder: (context, index, animation) {
                if (index < players.length) {
                  return ListTile(
                    title: Text(players[index]),
                    trailing: Icon(Icons.remove),
                  );
                } else {
                  return ListTile(trailing: Icon(Icons.add));
                }
              }),
        ),
        Wrap(
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
                Navigator.pop(context, players);
              },
            ),
          ],
        ),
      ],
    );
  }
}
