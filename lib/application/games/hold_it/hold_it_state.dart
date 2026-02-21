import '../../../domain/games/hold_it/hold_it_status.dart';
import '../../../domain/games/hold_it/score.dart';

class HoldItState {
  final HoldItStatus status;
  final int heldMs;
  final int targetValue;
  final Score score;

  const HoldItState({
    required this.status,
    required this.heldMs,
    required this.targetValue,
    required this.score,
  });

  factory HoldItState.initial() {
    return const HoldItState(
      status: HoldItStatus.idle,
      heldMs: 0,
      targetValue: 50,
      score: Score(0),
    );
  }

  HoldItState copyWith({
    HoldItStatus? status,
    int? heldMs,
    int? targetValue,
    Score? score,
  }) {
    return HoldItState(
      status: status ?? this.status,
      heldMs: heldMs ?? this.heldMs,
      targetValue: targetValue ?? this.targetValue,
      score: score ?? this.score,
    );
  }
}
