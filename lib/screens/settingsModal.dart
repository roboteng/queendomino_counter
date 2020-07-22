import 'package:flutter/material.dart';

class SettingsModal extends StatefulWidget {
  final List<String> players;

  const SettingsModal({Key key, this.players}) : super(key: key);

  @override
  _SettingsModalState createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  List<String> players;
  List<TextEditingController> _controllers;

  TextEditingController makeController(
    String startingText,
    void Function(String) callBack,
  ) {
    TextEditingController _cont = TextEditingController();
    _cont.text = startingText;
    _cont.addListener(() {
      callBack(_cont.text);
    });
    return _cont;
  }

  @override
  void initState() {
    players = widget.players;
    _controllers = [];
    for (int i = 0; i < players.length; i++) {
      _controllers.add(makeController(players[i], (String val) {
        players[i] = val;
      }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Modal Content'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: players.length + 1,
              itemBuilder: (context, index) {
                if (index < players.length) {
                  return ListTile(
                    title: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
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
