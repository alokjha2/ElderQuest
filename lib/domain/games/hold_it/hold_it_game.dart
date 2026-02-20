import 'hold_it_status.dart';
import 'score.dart';

class HoldItGame {
  static const int targetMs = 5000;
  static const int maxMs = 7000;

  final HoldItStatus status;
  final int heldMs;
  final Score score;

  const HoldItGame({
    required this.status,
    required this.heldMs,
    required this.score,
  });

  factory HoldItGame.initial() {
    return const HoldItGame(
      status: HoldItStatus.idle,
      heldMs: 0,
      score: Score(0),
    );
  }

  HoldItGame copyWith({
    HoldItStatus? status,
    int? heldMs,
    Score? score,
  }) {
    return HoldItGame(
      status: status ?? this.status,
      heldMs: heldMs ?? this.heldMs,
      score: score ?? this.score,
    );
  }

  HoldItGame startHold() {
    return copyWith(status: HoldItStatus.holding, heldMs: 0);
  }

  HoldItGame releaseHold() {
    if (heldMs >= targetMs && heldMs <= maxMs) {
      return copyWith(status: HoldItStatus.success, score: score.increment());
    }
    return copyWith(status: HoldItStatus.fail);
  }

  HoldItGame tick(int deltaMs) {
    return copyWith(heldMs: heldMs + deltaMs);
  }

  HoldItGame resetGame() => HoldItGame.initial();
}
