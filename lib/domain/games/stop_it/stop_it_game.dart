import 'score.dart';
import 'stop_it_status.dart';

class StopItGame {
  final StopItStatus status;
  final int elapsedHundredths;
  final int targetHundredths;
  final Score score;

  const StopItGame({
    required this.status,
    required this.elapsedHundredths,
    required this.targetHundredths,
    required this.score,
  });

  factory StopItGame.initial() {
    return const StopItGame(
      status: StopItStatus.idle,
      elapsedHundredths: 0,
      targetHundredths: 1000,
      score: Score(0),
    );
  }

  StopItGame copyWith({
    StopItStatus? status,
    int? elapsedHundredths,
    int? targetHundredths,
    Score? score,
  }) {
    return StopItGame(
      status: status ?? this.status,
      elapsedHundredths: elapsedHundredths ?? this.elapsedHundredths,
      targetHundredths: targetHundredths ?? this.targetHundredths,
      score: score ?? this.score,
    );
  }

  Score evaluateScore(int hundredths) {
    final diff = (hundredths - targetHundredths).abs();
    if (diff < 10) {
      return const Score(100);
    }
    if (diff < 30) {
      return const Score(70);
    }
    if (diff < 50) {
      return const Score(50);
    }
    if (diff < 100) {
      return const Score(20);
    }
    return const Score(0);
  }
}
