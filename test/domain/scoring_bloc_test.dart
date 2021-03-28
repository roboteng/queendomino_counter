import 'package:queendomino_counter/bloc/scoringBloc.dart';
import 'package:queendomino_counter/utils/scoring.dart';
import 'package:test/test.dart';

void main() {
  group("ScoringBloc Tests", () {
    ScoringBloc bloc;
    setUp(() {
      bloc = ScoringBloc();
    });

    test(
      'bloc should emit scores with all zeros for two players on start',
      () {
        expect(bloc.state.length, 2);
      },
    );

    test('should have 3 players after an AddPlayerEvent', () async {
      bloc.add(AddPlayerEvent());
      var state;
      await for (var event in bloc.stream) {
        state = event;
        break;
      }
      expect(state.length, 3);
    });

    test('should delete player', () async {
      bloc.add(RemovePlayerEvent());
      var state;
      await for (var event in bloc.stream) {
        state = event;
        break;
      }
      expect(state.length, 1);
    });
  });
}
