import 'package:equatable/equatable.dart';
import 'package:queendomino_counter/utils/scoring.dart';

import 'player.dart';

class PlayerScore extends Equatable {
  final Player player;
  final ScoringDetails details;
  PlayerScore(this.player) : this.details = ScoringDetails();

  int get total => details.total;
  @override
  List<Object> get props => [player, details];
}
