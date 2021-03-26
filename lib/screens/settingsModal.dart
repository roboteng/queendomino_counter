import 'package:flutter/material.dart';
import 'package:queendomino_counter/utils/playerList.dart';
import 'package:queendomino_counter/widgets/saveCancel.dart';

class SettingsModal extends StatefulWidget {
  final List<String> players;

  const SettingsModal({Key key, this.players}) : super(key: key);

  @override
  _SettingsModalState createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  List<DeletablePlayer> players;
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
    players = widget.players
        .map<DeletablePlayer>((String name) => DeletablePlayer(name))
        .toList();
    _controllers = [];
    for (int i = 0; i < players.length; i++) {
      if (players[i].isDeleted) {
        _controllers.add(null);
      } else {
        _controllers.add(
          makeController(
            players[i].name,
            (String val) {
              players[i].name = val;
            },
          ),
        );
      }
    }
    super.initState();
  }

  Widget columnChildren(int index) {
    if (index < players.length) {
      if (players[index].isDeleted) {
        return Container();
      } else {
        return ListTile(
          title: TextField(
            controller: _controllers[index],
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          trailing: TextButton(
            child: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                players[index].delete();
              });
            },
          ),
        );
      }
    } else {
      return ListTile(
        onTap: () {
          setState(() {
            players.add(
              DeletablePlayer(
                getNextPlayerName(
                  getPlayers(players),
                ),
              ),
            );
          });
          _controllers.add(makeController(players[index].name, (String val) {
            players[index].name = val;
          }));
        },
        trailing: Icon(Icons.add),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Modal Content'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            for (int i in Iterable.generate(players.length + 1))
              columnChildren(i)
          ]),
        ),
        SaveCancelOptions(
          returnParams: () => getPlayers(players),
        ),
      ],
    );
  }
}
