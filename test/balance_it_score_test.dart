import 'package:elder_quest/presentation/games/balance_it/balance_it_score.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('BalanceIt Score Calculation', () {
    test('perfect match gives 100', () {
      final score = calculateScore(50, 50);
      expect(score, 100);
    });

    test('small difference reduces score', () {
      final score = calculateScore(50, 52);
      expect(score, lessThan(100));
    });

    test('large difference clamps to 0', () {
      final score = calculateScore(0, 100);
      expect(score, 0);
    });

    test('score never exceeds 100', () {
      final score = calculateScore(10, 10);
      expect(score, lessThanOrEqualTo(100));
    });
    test('score clamps at 0 when difference too large', () {
  expect(calculateScore(0, 1000), 0);
});

test('negative target still works', () {
  expect(calculateScore(-50, -50), 100);
});

test('target still works', () {
  expect(calculateScore(-0, 0), 100);
});


  });
}