import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/utils/playerList.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:queendomino_counter/widgets/saveCancel.dart';

class EditPlayersModal extends StatefulWidget {
  final List<Player> players;

  const EditPlayersModal({Key key, this.players}) : super(key: key);

  @override
  _EditPlayersModalState createState() => _EditPlayersModalState();
}

class _EditPlayersModalState extends State<EditPlayersModal> {
  List<ScoringEvent> changes = [];
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
    _controllers = [];
    for (var p in widget.players) {
      _controllers.add(TextEditingController());
      _controllers.last.text = p.name;
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
            child: Icon(
              Icons.remove,
              semanticLabel: "Remove ${players[index].name}",
            ),
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
        trailing: Icon(
          Icons.add,
          semanticLabel: "Add New Player",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(8.0),
      title: Semantics(
        explicitChildNodes: true,
        header: true,
        child: Text('Edit Players'),
      ),
      children: <Widget>[
        Column(
          children: <Widget>[
            for (int i in Iterable.generate(players.length + 1))
              columnChildren(i),
            SaveCancelOptions(
              returnParams: () => changes,
            ),
          ],
        )
      ],
    );
  }
}
