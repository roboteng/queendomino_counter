import 'dart:async';
import 'dart:math';

import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:test/test.dart';

void main() {
  group("ScoringBloc Tests", () {
    ScoringBloc bloc;
    StreamGetter<List<PlayerScore>> s;

    setUp(() {
      bloc = ScoringBloc();
      s = StreamGetter(bloc.stream);
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
      final state = await s.getNextValue();

      expect(state.length, 3);
      expect(state[2].player, Player("Player 3"));
    });

    test('should remove first player if present', () async {
      bloc.add(RemovePlayerEvent(Player("Player 1")));
      final state = await s.getNextValue();

      expect(state.length, 1);
      expect(state[0].player, Player("Player 2"));
    });

    test('should remove second player if present', () async {
      bloc.add(RemovePlayerEvent(Player("Player 2")));
      final state = await s.getNextValue();

      expect(state.length, 1);
      expect(state[0].player, Player("Player 1"));
    });
    test('should add score to category for given player', () async {
      bloc.add(UpdateScoreEvent(
        Player("Player 1"),
        Coin(),
        1,
      ));
      final state = await s.getNextValue();
      expect(state[0].total, 1);
    });
    test('should sum the scores of the player', () async {
      final _l = bloc.stream.toList();
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
      final l = await _l;
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
      final _l = bloc.stream.toList();
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
      final l = await _l;
      expect(l.length, 2);
      expect(l[1][0].total, 2);
    });
  });
}

class StreamGetter<T> {
  var _i;
  final Stream<T> stream;

  StreamGetter(this.stream) : _i = 0;

  Future<T> getNextValue() {
    var c = Completer<T>();
    stream.elementAt(_i++).then(c.complete);
    return c.future;
  }
}
