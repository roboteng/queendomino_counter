import 'package:queendomino_counter/utils/categoryScoring.dart';

class ScoringEvent {
  int numPlayers;
  Category category;
  int base;
  int playerId;
  ScoringEvent({this.base, this.category, this.playerId, this.numPlayers})
      : assert((category == null) ^ (numPlayers == null)),
        assert((base == null) ^ (numPlayers == null)),
        assert((playerId == null) ^ (numPlayers == null));

  String toString() {
    return '$category $playerId, $base';
  }
}

class ScoringDetails {
  Map<Category, List<int>> details;

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

//used in the scoring breakout
int subScore(List<List<int>> elements, int Function(int, int) func) {
  int sum = 0;
  for (List<int> scores in elements) {
    sum += scores.reduce(func);
  }
  return sum;
}
