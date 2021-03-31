import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/providers/edit_players_modal_state.dart';
import 'package:queendomino_counter/widgets/saveCancel.dart';

class EditPlayersModal extends StatelessWidget {
  final List<Player> players;

  const EditPlayersModal({Key key, this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditPlayersModalState>(
        create: (_) => EditPlayersModalState(players),
        builder: (context, snapshot) {
          return Builder(builder: (context) {
            final state = context.watch<EditPlayersModalState>();
            return SimpleDialog(
              contentPadding: EdgeInsets.all(8.0),
              title: Semantics(
                explicitChildNodes: true,
                header: true,
                child: Text('Edit Players'),
              ),
              children: <Widget>[
                Column(
                  children: state.controllers
                      .map(
                        (c) => ListTile(
                          title: TextField(
                            controller: c,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.remove,
                              semanticLabel: "Remove ${c.text}",
                            ),
                            onPressed: () {
                              Provider.of<EditPlayersModalState>(context,
                                      listen: false)
                                  .removePlayer(Player(c.text));
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add,
                      semanticLabel: "Add New Player",
                    ),
                    onPressed: () => state.createNewPlayer(),
                  ),
                ),
                SaveCancelOptions(
                  returnParams: () =>
                      context.read<EditPlayersModalState>().changes,
                ),
              ],
            );
          });
        });
  }
}
