import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
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
      List<PlayerScore> state;
      await for (var event in bloc.stream) {
        state = event;
        break;
      }
      expect(state.length, 3);
      expect(state[2].player, Player("Player 3"));
    });

    test('should remove first player if present', () async {
      bloc.add(RemovePlayerEvent(Player("Player 1")));
      List<PlayerScore> state;
      await for (var event in bloc.stream) {
        state = event;
        break;
      }
      expect(state.length, 1);
      expect(state[0].player, Player("Player 2"));
    });

    test('should remove second player if present', () async {
      bloc.add(RemovePlayerEvent(Player("Player 2")));
      List<PlayerScore> state;
      await for (var event in bloc.stream) {
        state = event;
        break;
      }
      expect(state.length, 1);
      expect(state[0].player, Player("Player 1"));
    });
  });
}
