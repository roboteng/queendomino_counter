import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/ui/viewmodels/scoring_screen_viewmodel.dart';

class ScoringScreenViewmodelGenerator {
  ScoringScreenViewmodel generate(List<PlayerScore> scores) {
    return ScoringScreenViewmodel(
      columnTitles: scores.map((e) => e.player.name).toList(),
      footerTitles: scores.map((e) => e.total.toString()).toList(),
      rowTitles: categories.map((e) => e.shortString).toList(),
      cellLabels: categories
          .map((c) => scores
              .map((e) => (e.details.details[c] ?? 0).toString())
              .toList())
          .toList(),
    );
  }
}
