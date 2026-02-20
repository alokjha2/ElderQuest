import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../application/games/stop_it/stop_it_bloc.dart';
import '../../../application/games/stop_it/stop_it_event.dart';
import '../../../application/games/stop_it/stop_it_state.dart';
import '../../../domain/games/stop_it/stop_it_game.dart';
import '../../../domain/games/stop_it/stop_it_status.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../shared/end_score_page.dart';
import 'widgets/stop_button.dart';
import 'widgets/timer_display.dart';

class StopItPage extends HookWidget {
  const StopItPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StopItBloc(),
      child: BlocListener<StopItBloc, StopItState>(
        listenWhen: (prev, next) =>
            prev.status != StopItStatus.finished &&
            next.status == StopItStatus.finished,
        listener: (context, state) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EndScorePage(
                gameTitle: 'Stop It!',
                score: state.score.value,
                playRoute: '/stop-it',
              ),
            ),
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<StopItBloc, StopItState>(
                      builder: (context, state) {
                        return TimerDisplay(
                          elapsedHundredths: state.elapsedHundredths,
                          targetHundredths: StopItGame.targetHundredths,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s32),
                    BlocBuilder<StopItBloc, StopItState>(
                      builder: (context, state) {
                        final isRunning = state.status == StopItStatus.running;
                        return StopButton(
                          label: isRunning ? 'STOP' : 'START',
                          color: isRunning
                              ? AppColors.danger
                              : AppColors.primary,
                          onPressed: () {
                            if (isRunning) {
                              context.read<StopItBloc>().add(const StopItStopped());
                            } else {
                              context.read<StopItBloc>().add(const StopItStarted());
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
