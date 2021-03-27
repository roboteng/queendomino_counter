import 'package:flutter_test/flutter_test.dart';
import 'package:queendomino_counter/utils/categoryScoring.dart';
import 'package:queendomino_counter/utils/playerList.dart';
import 'package:queendomino_counter/utils/scoring.dart';

void main() {
  test('Testing sum of bloc results', () {
    final wheat = Wheat();
    final mines = Mines();
    final forest = Forest();
    ScoringDetails sumTest = ScoringDetails(
      details: {
        wheat: [1, 4],
        mines: [2, 5],
        forest: [3, 6]
      },
    );
    expect(sumTest.total(0), 6);
    expect(sumTest.total(1), 15);
  });
  group('testing naming functions', () {
    test('test only non-deleted players are returned', () {
      List<DeletablePlayer> players = [
        DeletablePlayer('James'),
        DeletablePlayer('Kevan'),
        DeletablePlayer('Roy'),
      ];
      players[1].delete();
      expect(getPlayers(players), ['James', 'Roy']);
    });
    test('Test player 1 function works', () {
      List<String> players = [
        'Player 1',
        'James',
        'Player 2',
        'Roy',
        'Player 4',
      ];
      expect(getNextPlayerName(players), 'Player 3');
    });
  });
}
