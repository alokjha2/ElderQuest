import '../../game_engine/score.dart';
import '../../game_engine/game_result.dart';
import 'tapme_status.dart';

class TapMeGame {
  final Score score;
  final TapMeStatus status;
  final int duration;
  final int remainingTime;

  const TapMeGame({
    required this.score,
    required this.status,
    required this.duration,
    required this.remainingTime,
  });

  factory TapMeGame.initial() {
    return TapMeGame(
      score: const Score(0),
      status: TapMeStatus.initial,
      duration: 10,
      remainingTime: 10,
    );
  }

  TapMeGame start() {
    return copyWith(
      status: TapMeStatus.playing,
      remainingTime: duration,
      score: score.reset(),
    );
  }

  TapMeGame tap() {
    if (status != TapMeStatus.playing) return this;
    return copyWith(score: score.increment());
  }

  TapMeGame tick() {
    if (status != TapMeStatus.playing) return this;

    if (remainingTime <= 1) {
      return copyWith(
        remainingTime: 0,
        status: TapMeStatus.finished,
      );
    }

    return copyWith(
      remainingTime: remainingTime - 1,
    );
  }

  GameResult toResult() {
    return GameResult(score: score.value);
  }

  TapMeGame copyWith({
    Score? score,
    TapMeStatus? status,
    int? remainingTime,
  }) {
    return TapMeGame(
      score: score ?? this.score,
      status: status ?? this.status,
      duration: duration,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}