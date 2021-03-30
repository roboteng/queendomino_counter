import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';

abstract class ScoringEvent {}

class AddPlayerEvent extends ScoringEvent {
  final Player player;
  AddPlayerEvent(this.player);
}

class RemovePlayerEvent extends ScoringEvent {
  final Player player;
  RemovePlayerEvent(this.player);
}

class ChangePlayerEvent extends ScoringEvent {
  final Player oldPlayerName;
  final Player newPlayerName;
  ChangePlayerEvent(this.oldPlayerName, this.newPlayerName);
}

class UpdateScoreEvent extends ScoringEvent {
  final Player player;
  final Category category;
  final int value;

  UpdateScoreEvent(this.player, this.category, this.value);
}

/// A map between each category, and the scores for that category
class ScoringDetails {
  Map<Category, int> details;

  ScoringDetails() : this.details = {};

  int get total => details.values.fold(0, (p, e) => p + e);
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
