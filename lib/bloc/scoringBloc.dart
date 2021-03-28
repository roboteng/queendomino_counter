import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/utils/scoring.dart';

class ScoringBloc extends Bloc<ScoringEvent, List<PlayerScore>> {
  ScoringBloc() : super([PlayerScore(), PlayerScore()]);
  @override
  Stream<List<PlayerScore>> mapEventToState(ScoringEvent event) async* {
    if (event is AddPlayerEvent) {
      yield state + [PlayerScore()];
    } else if (event is RemovePlayerEvent) {
      yield state.sublist(1);
    }
  }
}
