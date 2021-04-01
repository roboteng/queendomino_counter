import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/providers/edit_players_modal_state.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:test/test.dart';

void main() {
  EditPlayersModalState state;
  setUp(() {
    state = EditPlayersModalState([Player("Player 1"), Player("Player 2")]);
  });

  group("Testing the state of the edit players modal", () {
    test('Should have players when started', () {
      expect(state.controllers.length, 2);
      expect(state.controllers[0].text, "Player 1");
    });

    test('should create new player', () {
      state.createNewPlayer();
      expect(state.controllers.length, 3);
      expect(state.controllers.last.text, "Player 3");
    });

    test('should create new player with the next "Player \$n" format', () {
      state.createNewPlayer();
      expect(state.controllers[2].text, "Player 3");
      expect(state.changes[0], isA<AddPlayerEvent>());
    });

    test('should remove the correct player', () {
      state.removePlayer(Player("Player 2"));
      expect(state.controllers.indexWhere((c) => c.text == "Player 2"), -1);
      expect(state.changes[0], isA<RemovePlayerEvent>());
      expect(
        (state.changes[0] as RemovePlayerEvent).player,
        Player("Player 2"),
      );
    });

    test('Updating a players name should add an event to the list', () {
      state.init();
      state.controllers[0].text = "Player 12";
      expect(state.changes.length, 1);
      expect(state.changes[0], isA<ChangePlayerEvent>());
      expect(
        (state.changes[0] as ChangePlayerEvent).oldPlayerName,
        Player("Player 1"),
      );
      expect(
        (state.changes[0] as ChangePlayerEvent).newPlayerName,
        Player("Player 12"),
      );
    });
    test('Updating a players name twice should add two events to the list', () {
      state.init();
      state.controllers[0].text = "Player 12";
      state.controllers[0].text = "Player 123";
      expect(state.changes.length, 2);
      expect(state.changes[1], isA<ChangePlayerEvent>());
      expect(
        (state.changes[1] as ChangePlayerEvent).oldPlayerName,
        Player("Player 12"),
      );
      expect(
        (state.changes[1] as ChangePlayerEvent).newPlayerName,
        Player("Player 123"),
      );
    });
  });
}
