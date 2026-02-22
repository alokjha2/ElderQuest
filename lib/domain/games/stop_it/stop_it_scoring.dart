const double stopItPerfectWindowSeconds = 0.05;
const double stopItPenaltyPerSecond = 60.0;
const int stopItMaxScore = 100;

const String stopItResultPerfect = 'perfect';
const String stopItResultInsane = 'insane';
const String stopItResultGreat = 'great';
const String stopItResultGood = 'good';
const String stopItResultOk = 'ok';
const String stopItResultMiss = 'miss';

class StopItScoreResult {
  final int score;
  final double difference;
  final String resultType;

  const StopItScoreResult({
    required this.score,
    required this.difference,
    required this.resultType,
  });
}

StopItScoreResult calculateStopItScore({
  required double stopTimeSeconds,
  required double targetTimeSeconds,
}) {
  final difference = (targetTimeSeconds - stopTimeSeconds).abs();

  if (difference <= stopItPerfectWindowSeconds) {
    return StopItScoreResult(
      score: stopItMaxScore,
      difference: difference,
      resultType: stopItResultPerfect,
    );
  }

  final rawScore = stopItMaxScore - (difference * stopItPenaltyPerSecond);
  final score = rawScore <= 0
      ? 0
      : rawScore >= stopItMaxScore
          ? stopItMaxScore
          : rawScore.round();

  if (score == stopItMaxScore) {
    return StopItScoreResult(
      score: score,
      difference: difference,
      resultType: stopItResultPerfect,
    );
  }
  if (score >= 90) {
    return StopItScoreResult(
      score: score,
      difference: difference,
      resultType: stopItResultInsane,
    );
  }
  if (score >= 75) {
    return StopItScoreResult(
      score: score,
      difference: difference,
      resultType: stopItResultGreat,
    );
  }
  if (score >= 50) {
    return StopItScoreResult(
      score: score,
      difference: difference,
      resultType: stopItResultGood,
    );
  }
  if (score > 0) {
    return StopItScoreResult(
      score: score,
      difference: difference,
      resultType: stopItResultOk,
    );
  }
  return StopItScoreResult(
    score: 0,
    difference: difference,
    resultType: stopItResultMiss,
  );
}
