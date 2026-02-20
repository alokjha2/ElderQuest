import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/games/hold_it/hold_it_game.dart';
import '../../../domain/games/hold_it/hold_it_status.dart';
import '../../../domain/games/hold_it/score.dart';
import 'hold_it_event.dart';
import 'hold_it_state.dart';

class HoldItBloc extends Bloc<HoldItEvent, HoldItState> {
  final HoldItGame game;
  Timer? _timer;

  HoldItBloc({HoldItGame? game})
      : game = game ?? HoldItGame.initial(),
        super(HoldItState.initial()) {
    on<StartHoldEvent>(_onStart);
    on<TimerTickEvent>(_onTick);
    on<ReleaseHoldEvent>(_onRelease);
    on<EndGameEvent>(_onEnd);
    on<ResetHoldEvent>(_onReset);
  }

  void _onStart(StartHoldEvent event, Emitter<HoldItState> emit) {
    _timer?.cancel();
    emit(state.copyWith(
      status: HoldItStatus.holding,
      heldMs: 0,
      score: const Score(0),
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
    if (state.heldMs >= HoldItGame.targetMs &&
        state.heldMs <= HoldItGame.maxMs) {
      emit(state.copyWith(
        status: HoldItStatus.success,
        score: state.score.increment(),
      ));
    } else {
      emit(state.copyWith(status: HoldItStatus.fail));
    }
  }

  void _onEnd(EndGameEvent event, Emitter<HoldItState> emit) {
    _timer?.cancel();
    emit(state.copyWith(status: HoldItStatus.fail));
  }

  void _onReset(ResetHoldEvent event, Emitter<HoldItState> emit) {
    _timer?.cancel();
    emit(HoldItState.initial());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
