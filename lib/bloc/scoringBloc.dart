import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/utils/scoring.dart';

//simple case where only one territory counts
//to be turned into a list later
class ScoringBloc extends Bloc<ScoringEvent, ScoringDetails> {
  ScoringBloc()
      : super(
          ScoringDetails(
            details: {
              for (String category in kCategories) category: [0, 0, 0, 0, 0, 0]
            },
          ),
        );

  @override
  Stream<ScoringDetails> mapEventToState(ScoringEvent event) async* {
    print(event);
    if (event.numPlayers == null) {
      Map<String, List<int>> _map = state.details;
      _map[event.type][event.playerId] = event.base;
      yield ScoringDetails(details: _map);
    } else {
      for (List<int> list in state.details.values) {
        list.add(0);
      }
      yield ScoringDetails(details: state.details);
    }
  }
}
