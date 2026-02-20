import 'dart:async';
import 'package:elder_quest/domain/games/tapme/tapme_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/games/tapme/tapme_game.dart';
import 'tapme_event.dart';
import 'tapme_state.dart';

class TapMeBloc extends Bloc<TapMeEvent, TapMeState> {
  Timer? _timer;

  TapMeBloc() : super(TapMeState(TapMeGame.initial())) {
    on<TapMeStarted>(_onStarted);
    on<TapMeTapped>(_onTapped);
    on<TapMeTicked>(_onTicked);
  }

  void _onStarted(TapMeStarted event, Emitter<TapMeState> emit) {
    final game = state.game.start();
    emit(TapMeState(game));

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(TapMeTicked()),
    );
  }

  void _onTapped(TapMeTapped event, Emitter<TapMeState> emit) {
    emit(TapMeState(state.game.tap()));
  }

  void _onTicked(TapMeTicked event, Emitter<TapMeState> emit) {
    final updated = state.game.tick();
    emit(TapMeState(updated));

    if (updated.status == TapMeStatus.finished) {
      _timer?.cancel();
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}