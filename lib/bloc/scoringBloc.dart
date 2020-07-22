import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queendomino_counter/constants/constants.dart';

//simple case where only one territory counts
//to be turned into a list later
class ScoringBloc extends Bloc<ScoringEvent, ScoringDetails> {
  ScoringBloc()
      : super(
          ScoringDetails(
            details: {
              for (String category in kCategories) category: [0, 0]
            },
          ),
        );

  @override
  Stream<ScoringDetails> mapEventToState(ScoringEvent event) async* {
    print(event);
    Map<String, List<int>> _map = state.details;
    _map[event.type][event.playerId] = event.base;
    yield ScoringDetails(details: _map);
  }
}

class ScoringEvent {
  String type;
  int base;
  int playerId;
  ScoringEvent({this.base, this.type, this.playerId})
      : assert(type != null),
        assert(base != null),
        assert(playerId != null),
        assert(base >= 0),
        assert(type != '');

  String toString() {
    return '$type $playerId, $base';
  }
}

class ScoringDetails {
  Map<String, List<int>> details;

  ScoringDetails({this.details}) : assert(details != null);

  int total(int playerID) {
    return details.values.reduce(vectorAdd)[playerID];
  }
}

List<int> vectorAdd(List<int> it, List<int> other) {
  assert(it.length == other.length);
  List<int> values = [];
  for (int i = 0; i < it.length; i += 1) {
    values.add(it[i] + other[i]);
  }
  return values;
}
