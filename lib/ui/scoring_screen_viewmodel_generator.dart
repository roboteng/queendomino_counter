import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/ui/viewmodels/scoring_screen_viewmodel.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';

class ScoringScreenViewmodelGenerator {
  ScoringScreenViewmodel generate(List<PlayerScore> scores) {
    return ScoringScreenViewmodel(
      columnTitles: scores.map((e) => e.player.name).toList(),
      footerTitles: scores.map((e) => e.total.toString()).toList(),
      rowTitles: categories.map((e) => e.shortString).toList(),
      cellLabels: _generateForCell(
        scores,
        (category, score) => (score.details.details[category] ?? 0).toString(),
      ),
      cellOnTap: _generateForCell(scores, (_, __) => () {}),
    );
  }

  List<List<T>> _generateForCell<T>(
    List<PlayerScore> scores,
    T Function(Category, PlayerScore) func,
  ) {
    return categories
        .map((c) => scores
            .map(
              (e) => func(c, e),
            )
            .toList())
        .toList();
  }
}
