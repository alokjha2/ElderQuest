import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/games/stop_it/stop_it_game.dart';
import '../../../domain/games/stop_it/score.dart';
import '../../../domain/games/stop_it/stop_it_status.dart';
import 'stop_it_event.dart';
import 'stop_it_state.dart';

class StopItBloc extends Bloc<StopItEvent, StopItState> {
  final StopItGame game;
  Timer? _timer;

  StopItBloc({StopItGame? game})
      : game = game ?? StopItGame.initial(),
        super(StopItState.initial()) {
    on<StopItStarted>(_onStarted);
    on<StopItTicked>(_onTicked);
    on<StopItStopped>(_onStopped);
    on<StopItReset>(_onReset);
  }

  void _onStarted(StopItStarted event, Emitter<StopItState> emit) {
    _timer?.cancel();
    final options = [10, 12, 14, 16, 18, 20, 22, 24, 26, 28];
    final targetSeconds = options[Random().nextInt(options.length)];
    final targetHundredths = targetSeconds * 100;
    emit(state.copyWith(
      status: StopItStatus.running,
      elapsedHundredths: 0,
      targetHundredths: targetHundredths,
      score: const Score(0),
    ));
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      add(const StopItTicked());
    });
  }

  void _onTicked(StopItTicked event, Emitter<StopItState> emit) {
    if (state.status != StopItStatus.running) return;
    emit(state.copyWith(elapsedHundredths: state.elapsedHundredths + 1));
  }

  void _onStopped(StopItStopped event, Emitter<StopItState> emit) {
    if (state.status != StopItStatus.running) return;
    _timer?.cancel();
    final score = StopItGame(
      status: state.status,
      elapsedHundredths: state.elapsedHundredths,
      targetHundredths: state.targetHundredths,
      score: state.score,
    ).evaluateScore(state.elapsedHundredths);
    emit(state.copyWith(
      status: StopItStatus.finished,
      score: score,
    ));
  }

  void _onReset(StopItReset event, Emitter<StopItState> emit) {
    _timer?.cancel();
    emit(StopItState.initial());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
