const int holdItMaxScore = 100;
const int holdItPenaltyPerUnit = 3;
const int holdItPerfectScore = 100;
const int holdItAlmostPerfectScore = 98;
const int holdItGreatScore = 96;

const String holdItResultOverflow = 'overflow';
const String holdItResultPerfect = 'perfect';
const String holdItResultAlmostPerfect = 'almost_perfect';
const String holdItResultGreat = 'great';
const String holdItResultNormal = 'normal';

class HoldItScoreResult {
  final int score;
  final int difference;
  final String resultType;

  const HoldItScoreResult({
    required this.score,
    required this.difference,
    required this.resultType,
  });
}

HoldItScoreResult calculateScore(int releaseValue, int targetValue) {
  if (releaseValue > targetValue) {
    return HoldItScoreResult(
      score: 0,
      difference: releaseValue - targetValue,
      resultType: holdItResultOverflow,
    );
  }

  final difference = targetValue - releaseValue;
  int score = holdItMaxScore - (difference * holdItPenaltyPerUnit);
  if (score < 0) {
    score = 0;
  } else if (score > holdItMaxScore) {
    score = holdItMaxScore;
  }

  if (difference == 0) {
    return HoldItScoreResult(
      score: holdItPerfectScore,
      difference: difference,
      resultType: holdItResultPerfect,
    );
  }
  if (difference == 1) {
    return HoldItScoreResult(
      score: holdItAlmostPerfectScore,
      difference: difference,
      resultType: holdItResultAlmostPerfect,
    );
  }
  if (difference == 2) {
    return HoldItScoreResult(
      score: holdItGreatScore,
      difference: difference,
      resultType: holdItResultGreat,
    );
  }

  return HoldItScoreResult(
    score: score,
    difference: difference,
    resultType: holdItResultNormal,
  );
}
