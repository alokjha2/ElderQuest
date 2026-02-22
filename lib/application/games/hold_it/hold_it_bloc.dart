import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/games/hold_it/hold_it_game.dart';
import '../../../domain/games/hold_it/hold_it_scoring.dart';
import '../../../domain/games/hold_it/hold_it_status.dart';
import '../../../domain/games/hold_it/score.dart';
import 'hold_it_event.dart';
import 'hold_it_state.dart';

class HoldItBloc extends Bloc<HoldItEvent, HoldItState> {
  final HoldItGame game;
  Timer? _timer;
  final Random _random = Random();

  HoldItBloc({HoldItGame? game})
      : game = game ?? HoldItGame.initial(),
        super(HoldItState.initial()) {
    on<StartHoldEvent>(_onStart);
    on<TimerTickEvent>(_onTick);
    on<ReleaseHoldEvent>(_onRelease);
    on<EndGameEvent>(_onEnd);
    on<ResetHoldEvent>(_onReset);
  }

  int _pickTargetValue() {
    final values = <int>[];
    for (int v = 5; v <= 95; v += 5) {
      values.add(v);
    }
    return values[_random.nextInt(values.length)];
  }

  void _onStart(StartHoldEvent event, Emitter<HoldItState> emit) {
    _timer?.cancel();
    emit(state.copyWith(
      status: HoldItStatus.holding,
      heldMs: 0,
      score: const Score(0),
      difference: 0,
      resultType: holdItResultNormal,
    ));
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      add(const TimerTickEvent(50));
    });
  }

  void _onTick(TimerTickEvent event, Emitter<HoldItState> emit) {
    if (state.status != HoldItStatus.holding) return;
    emit(state.copyWith(heldMs: state.heldMs + event.deltaMs));
    if (state.heldMs >= HoldItGame.maxMs) {
      add(const EndGameEvent());
    }
  }

  void _onRelease(ReleaseHoldEvent event, Emitter<HoldItState> emit) {
    if (state.status != HoldItStatus.holding) return;
    _timer?.cancel();
    final rawReleaseValue =
        ((state.heldMs / HoldItGame.maxMs) * 100).round();
    final releaseValue = rawReleaseValue.clamp(0, 100) as int;
    final result = calculateScore(releaseValue, state.targetValue);
    final status = result.resultType == holdItResultOverflow
        ? HoldItStatus.fail
        : HoldItStatus.success;

    emit(state.copyWith(
      status: status,
      score: Score(result.score),
      difference: result.difference,
      resultType: result.resultType,
    ));
  }

  void _onEnd(EndGameEvent event, Emitter<HoldItState> emit) {
    _timer?.cancel();
    emit(state.copyWith(
      status: HoldItStatus.fail,
      score: const Score(0),
      difference: 0,
      resultType: holdItResultOverflow,
    ));
  }

  void _onReset(ResetHoldEvent event, Emitter<HoldItState> emit) {
    _timer?.cancel();
    emit(
      HoldItState.initial().copyWith(
        targetValue: _pickTargetValue(),
        resultType: holdItResultNormal,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
