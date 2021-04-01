import 'package:flutter/widgets.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/utils/playerList.dart';
import 'package:queendomino_counter/utils/scoring.dart';

class EditPlayersModalState extends ChangeNotifier {
  List<Player> players;
  List<ScoringEvent> changes = [];
  List<TextEditingController> controllers;

  EditPlayersModalState(this.players)
      : this.controllers =
            players.map((e) => TextEditingController()..text = e.name).toList();

  void init() {
    controllers.forEach((controller) {
      controller.addListener(() {
        final i = controllers.indexOf(controller);
        final newPlayer = Player(controller.text);
        changes.add(ChangePlayerEvent(players[i], newPlayer));
        players[i] = newPlayer;
        //notifyListeners();
      });
    });
  }

  void createNewPlayer() {
    players.add(Player(getNextPlayerName(players.map((e) => e.name).toList())));
    changes.add(AddPlayerEvent(players.last));
    controllers.add(TextEditingController()..text = players.last.name);
    notifyListeners();
  }

  void removePlayer(Player player) {
    players.remove(player);
    changes.add(RemovePlayerEvent(player));
    controllers.removeWhere((c) => c.text == player.name);
    notifyListeners();
  }

  @override
  void dispose() {
    controllers.forEach((c) => c.dispose());
    super.dispose();
  }
}
