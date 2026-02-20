import '../../../domain/games/stop_it/score.dart';
import '../../../domain/games/stop_it/stop_it_status.dart';

class StopItState {
  final StopItStatus status;
  final int elapsedHundredths;
  final Score score;

  const StopItState({
    required this.status,
    required this.elapsedHundredths,
    required this.score,
  });

  factory StopItState.initial() {
    return const StopItState(
      status: StopItStatus.idle,
      elapsedHundredths: 0,
      score: Score(0),
    );
  }

  StopItState copyWith({
    StopItStatus? status,
    int? elapsedHundredths,
    Score? score,
  }) {
    return StopItState(
      status: status ?? this.status,
      elapsedHundredths: elapsedHundredths ?? this.elapsedHundredths,
      score: score ?? this.score,
    );
  }
}
