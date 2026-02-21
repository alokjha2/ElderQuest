import '../../../domain/games/stop_it/score.dart';
import '../../../domain/games/stop_it/stop_it_status.dart';

class StopItState {
  final StopItStatus status;
  final int elapsedHundredths;
  final int targetHundredths;
  final int maxHundredths;
  final Score score;

  const StopItState({
    required this.status,
    required this.elapsedHundredths,
    required this.targetHundredths,
    required this.maxHundredths,
    required this.score,
  });

  factory StopItState.initial() {
    return const StopItState(
      status: StopItStatus.idle,
      elapsedHundredths: 0,
      targetHundredths: 1000,
      maxHundredths: 1400,
      score: Score(0),
    );
  }

  StopItState copyWith({
    StopItStatus? status,
    int? elapsedHundredths,
    int? targetHundredths,
    int? maxHundredths,
    Score? score,
  }) {
    return StopItState(
      status: status ?? this.status,
      elapsedHundredths: elapsedHundredths ?? this.elapsedHundredths,
      targetHundredths: targetHundredths ?? this.targetHundredths,
      maxHundredths: maxHundredths ?? this.maxHundredths,
      score: score ?? this.score,
    );
  }
}
