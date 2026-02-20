import '../../../domain/games/hold_it/hold_it_status.dart';
import '../../../domain/games/hold_it/score.dart';

class HoldItState {
  final HoldItStatus status;
  final int heldMs;
  final Score score;

  const HoldItState({
    required this.status,
    required this.heldMs,
    required this.score,
  });

  factory HoldItState.initial() {
    return const HoldItState(
      status: HoldItStatus.idle,
      heldMs: 0,
      score: Score(0),
    );
  }

  HoldItState copyWith({
    HoldItStatus? status,
    int? heldMs,
    Score? score,
  }) {
    return HoldItState(
      status: status ?? this.status,
      heldMs: heldMs ?? this.heldMs,
      score: score ?? this.score,
    );
  }
}
