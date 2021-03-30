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
    final result = event.getNextState(state);
    if (result != null) {
      yield result;
    }
  }
}
