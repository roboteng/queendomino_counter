import 'package:equatable/equatable.dart';

import 'player.dart';

class PlayerScore extends Equatable {
  final Player player;
  PlayerScore(this.player);

  get total => 0;
  @override
  List<Object> get props => [player];
}
