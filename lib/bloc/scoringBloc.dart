import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/utils/scoring.dart';

class ScoringBloc extends Bloc<ScoringEvent, List<PlayerScore>> {
  ScoringBloc()
      : super(
            [PlayerScore(Player("Player 1")), PlayerScore(Player("Player 2"))]);
  @override
  Stream<List<PlayerScore>> mapEventToState(ScoringEvent event) async* {
    if (event is AddPlayerEvent) {
      yield state + [PlayerScore(event.player)];
    } else if (event is RemovePlayerEvent) {
      yield state..removeWhere((p) => p.player == event.player);
    } else if (event is UpdateScoreEvent) {
      state
          .firstWhere((element) => element.player == event.player)
          .details
          .details[event.category] = event.value;
      yield state.map((e) => e).toList();
    } else {
      yield state;
    }
  }
}
