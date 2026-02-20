import 'score.dart';
import 'stop_it_status.dart';

class StopItGame {
  static const int targetHundredths = 1000; // 10.00s

  final StopItStatus status;
  final int elapsedHundredths;
  final Score score;

  const StopItGame({
    required this.status,
    required this.elapsedHundredths,
    required this.score,
  });

  factory StopItGame.initial() {
    return const StopItGame(
      status: StopItStatus.idle,
      elapsedHundredths: 0,
      score: Score(0),
    );
  }

  StopItGame copyWith({
    StopItStatus? status,
    int? elapsedHundredths,
    Score? score,
  }) {
    return StopItGame(
      status: status ?? this.status,
      elapsedHundredths: elapsedHundredths ?? this.elapsedHundredths,
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
