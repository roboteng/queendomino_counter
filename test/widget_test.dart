import 'package:flutter_test/flutter_test.dart';
import 'package:queendomino_counter/bloc/scoringBloc.dart';

void main() {
  test('Testing sum of bloc results', () {
    ScoringDetails sumTest = ScoringDetails(
      details: {
        'one': [1, 4],
        'two': [2, 5],
        'three': [3, 6]
      },
    );
    expect(sumTest.total(0), 6);
    expect(sumTest.total(1), 15);
  });
}
