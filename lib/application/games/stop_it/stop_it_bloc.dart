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
        super(_initialState()) {
    on<StopItStarted>(_onStarted);
    on<StopItTicked>(_onTicked);
    on<StopItStopped>(_onStopped);
    on<StopItReset>(_onReset);
  }

  static StopItState _initialState() {
    final target = _pickTargetHundredths();
    final buffer = _pickBufferHundredths();
    return StopItState(
      status: StopItStatus.idle,
      elapsedHundredths: 0,
      targetHundredths: target,
      maxHundredths: target + buffer,
      score: const Score(0),
    );
  }

  static int _pickTargetHundredths() {
    final options = [8, 10, 12, 14, 16, 18];
    final targetSeconds = options[Random().nextInt(options.length)];
    return targetSeconds * 100;
  }

  static int _pickBufferHundredths() {
    final options = [5, 6, 10, 14, 18];
    final bufferSeconds = options[Random().nextInt(options.length)];
    return bufferSeconds * 100;
  }

  void _onStarted(StopItStarted event, Emitter<StopItState> emit) {
    _timer?.cancel();
    final buffer = _pickBufferHundredths();
    emit(state.copyWith(
      status: StopItStatus.running,
      elapsedHundredths: 0,
      targetHundredths: state.targetHundredths,
      maxHundredths: state.targetHundredths + buffer,
      score: const Score(0),
    ));
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      add(const StopItTicked());
    });
  }

  void _onTicked(StopItTicked event, Emitter<StopItState> emit) {
    if (state.status != StopItStatus.running) return;
    final nextElapsed = state.elapsedHundredths + 1;
    if (nextElapsed >= state.targetHundredths ||
        nextElapsed >= state.maxHundredths) {
      _finish(nextElapsed, emit);
      return;
    }
    emit(state.copyWith(elapsedHundredths: nextElapsed));
  }

  void _onStopped(StopItStopped event, Emitter<StopItState> emit) {
    if (state.status != StopItStatus.running) return;
    _timer?.cancel();
    _finish(state.elapsedHundredths, emit);
  }

  void _onReset(StopItReset event, Emitter<StopItState> emit) {
    _timer?.cancel();
    final target = _pickTargetHundredths();
    final buffer = _pickBufferHundredths();
    emit(StopItState(
      status: StopItStatus.idle,
      elapsedHundredths: 0,
      targetHundredths: target,
      maxHundredths: target + buffer,
      score: const Score(0),
    ));
  }

  void _finish(int elapsed, Emitter<StopItState> emit) {
    _timer?.cancel();
    final score = StopItGame(
      status: state.status,
      elapsedHundredths: elapsed,
      targetHundredths: state.targetHundredths,
      score: state.score,
    ).evaluateScore(elapsed);
    emit(state.copyWith(
      status: StopItStatus.finished,
      elapsedHundredths: elapsed,
      score: score,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
