import '../../../domain/games/hold_it/hold_it_status.dart';
import '../../../domain/games/hold_it/score.dart';

class HoldItState {
  final HoldItStatus status;
  final int heldMs;
  final int targetValue;
  final Score score;
  final int difference;
  final String resultType;

  const HoldItState({
    required this.status,
    required this.heldMs,
    required this.targetValue,
    required this.score,
    required this.difference,
    required this.resultType,
  });

  factory HoldItState.initial() {
    return const HoldItState(
      status: HoldItStatus.idle,
      heldMs: 0,
      targetValue: 50,
      score: Score(0),
      difference: 0,
      resultType: 'normal',
    );
  }

  HoldItState copyWith({
    HoldItStatus? status,
    int? heldMs,
    int? targetValue,
    Score? score,
    int? difference,
    String? resultType,
  }) {
    return HoldItState(
      status: status ?? this.status,
      heldMs: heldMs ?? this.heldMs,
      targetValue: targetValue ?? this.targetValue,
      score: score ?? this.score,
      difference: difference ?? this.difference,
      resultType: resultType ?? this.resultType,
    );
  }
}
