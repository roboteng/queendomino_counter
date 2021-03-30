import 'package:queendomino_counter/constants/constants.dart';
import 'package:queendomino_counter/domain/entities/player.dart';
import 'package:queendomino_counter/domain/entities/player_score.dart';
import 'package:queendomino_counter/ui/scoring_screen_viewmodel_generator.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:test/test.dart';

void main() {
  group(
      "Testing the conversion from List<PlayerScores> to ScoringScreenViemodels",
      () {
    ScoringScreenViewmodelGenerator g;
    setUp(() {
      g = ScoringScreenViewmodelGenerator();
    });
    test("Should produce the players names", () {
      final state =
          List.generate(2, (i) => PlayerScore(Player("Player ${i + 1}")));
      expect(g.generate(state).columnTitles, ["Player 1", "Player 2"]);
    });

    test("Should produce the correct totals", () {
      final state =
          List.generate(2, (i) => PlayerScore(Player("Player ${i + 1}")));
      state[0].details.details[Coin()] = 1;
      state[1].details.details[Wheat()] = 2;
      expect(g.generate(state).footerTitles, ["1", "2"]);
    });

    test("Should generate the row titles", () {
      expect(g.generate([]).rowTitles,
          categories.map((e) => e.shortString).toList());
    });

    test("Should produce zero value for blank entry", () {
      final state =
          List.generate(2, (i) => PlayerScore(Player("Player ${i + 1}")));

      expect(g.generate(state).cellLabels[0][0], "0");
    });

    test("Should produce the correct resource type in the correct spot", () {
      final state =
          List.generate(2, (i) => PlayerScore(Player("Player ${i + 1}")));
      state[0].details.details[Coin()] = 1;
      state[1].details.details[Wheat()] = 2;
      expect(g.generate(state).cellLabels[categories.indexOf(Coin())][0], "1");
      expect(g.generate(state).cellLabels[categories.indexOf(Wheat())][1], "2");
    });

    test('cells length should be as long as categories', () {
      expect(g.generate([]).cellLabels.length, categories.length);
    });

    test('cells should have onTap', () {
      expect(
        g
            .generate([PlayerScore(Player("Player 1"))],
                (Category c, PlayerScore score) => () {})
            .cellOnTap
            .length,
        categories.length,
      );
    });
  });
}
