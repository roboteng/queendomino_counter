import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:test/test.dart';

void main() {
  group("ScoringBloc Tests", () {
    ScoringBloc bloc;

    setUp(() {
      bloc = ScoringBloc();
    });

    test('bloc should emit scores with all zeros for two players on start', () {
      expect(bloc.state.length, 2);
      for (var player in bloc.state) {
        expect(player.total, 0);
      }
      expect(bloc.state[0].player, Player("Player 1"));
      expect(bloc.state[1].player, Player("Player 2"));
    });

    test('should have 3 players after an AddPlayerEvent', () async {
      bloc.add(AddPlayerEvent(Player("Player 3")));
      bloc.close();
      final state = (await bloc.stream.toList())[0];
      expect(state.length, 3);
      expect(state[2].player, Player("Player 3"));
    });

    test('should remove first player if present', () async {
      bloc.add(RemovePlayerEvent(Player("Player 1")));
      bloc.close();
      final state = (await bloc.stream.toList())[0];
      expect(state.length, 1);
      expect(state[0].player, Player("Player 2"));
    });

    test('should remove second player if present', () async {
      bloc.add(RemovePlayerEvent(Player("Player 2")));
      bloc.close();
      final state = (await bloc.stream.toList())[0];
      expect(state.length, 1);
      expect(state[0].player, Player("Player 1"));
    });
    test('should add score to category for given player', () async {
      bloc.add(UpdateScoreEvent(
        Player("Player 1"),
        Coin(),
        1,
      ));
      bloc.close();
      final state = (await bloc.stream.toList())[0];
      expect(state[0].total, 1);
    });
    test('should sum the scores of the player', () async {
      bloc.add(UpdateScoreEvent(
        Player("Player 1"),
        Coin(),
        1,
      ));

      bloc.add(UpdateScoreEvent(
        Player("Player 1"),
        Wheat(),
        2,
      ));

      bloc.close();
      final l = (await bloc.stream.toList());
      expect(l.length, 2);
      expect(l[1][0].total, 3);
    });

    test('two Coin() should be the same', () {
      expect(Coin(), Coin());
    });

    test(' Coin() and Wheat() should be different', () {
      expect(Coin(), isNot(Wheat()));
    });

    test('should sum the scores of the player, even with updated category',
        () async {
      bloc.add(UpdateScoreEvent(
        Player("Player 1"),
        Coin(),
        1,
      ));

      bloc.add(UpdateScoreEvent(
        Player("Player 1"),
        Coin(),
        2,
      ));

      bloc.close();
      final l = await bloc.stream.toList();
      expect(l.length, 2);
      expect(l[1][0].total, 2);
    });

    test("Players name should update, if given the correct PlayerChangeEvent",
        () async {
      bloc.add(ChangePlayerEvent(Player("Player 1"), Player("Trevor")));
      bloc.close();
      final state = (await bloc.stream.toList())[0];
      expect(state.length, 2);
      expect(state[0].player, Player("Trevor"));
    });

    test("if player given that doesn't exists, nothig should happen", () async {
      bloc.add(ChangePlayerEvent(Player("Bad Name"), Player("Trevor")));
      bloc.close();
      final l = await bloc.stream.toList();
      expect(l.length, 0);
    });
    test(
        "Players name should update, if given the correct PlayerChangeEvent, after a lot of events",
        () async {
      bloc.add(ChangePlayerEvent(Player("Player 1"), Player("Player ")));
      bloc.add(ChangePlayerEvent(Player("Player "), Player("Player")));
      bloc.add(ChangePlayerEvent(Player("Player"), Player("Playe")));
      bloc.add(ChangePlayerEvent(Player("Playe"), Player("Play")));
      bloc.add(ChangePlayerEvent(Player("Play"), Player("Pla")));
      bloc.add(ChangePlayerEvent(Player("Pla"), Player("Pl")));
      bloc.add(ChangePlayerEvent(Player("Pl"), Player("P")));
      bloc.add(ChangePlayerEvent(Player("P"), Player("")));
      bloc.add(ChangePlayerEvent(Player(""), Player("T")));
      bloc.add(ChangePlayerEvent(Player("T"), Player("Tr")));
      bloc.add(ChangePlayerEvent(Player("Tr"), Player("Tre")));
      bloc.add(ChangePlayerEvent(Player("Tre"), Player("Trev")));
      bloc.add(ChangePlayerEvent(Player("Trev"), Player("Trevo")));
      bloc.add(ChangePlayerEvent(Player("Trevo"), Player("Trevor")));
      bloc.close();
      final state = (await bloc.stream.toList()).last;
      expect(state.length, 2);
      expect(state[0].player, Player("Trevor"));
    });
  });
}
