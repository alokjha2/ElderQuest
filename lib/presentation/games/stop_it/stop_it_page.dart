import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/audio/audio_levels.dart';
import '../../../core/audio/game_audio_player.dart';
import '../../../application/games/stop_it/stop_it_bloc.dart';
import '../../../application/games/stop_it/stop_it_event.dart';
import '../../../application/games/stop_it/stop_it_state.dart';
import '../../../domain/games/stop_it/stop_it_status.dart';
import '../../../core/component/game_page_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../shared/end_score/end_score_page.dart';
import 'widgets/led_display_panel.dart';

class StopItPage extends HookWidget {
  const StopItPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tickSfx = useMemoized(GameAudioPlayer.new);
    useEffect(() {
      AudioService.instance
          .setBackgroundVolume(AudioService.gameplayBackgroundVolume);
      context.read<StopItBloc>().add(const StopItReset());
      return () {
        tickSfx.dispose();
      };
    }, const []);

    return MultiBlocListener(
      listeners: [
        BlocListener<StopItBloc, StopItState>(
          listenWhen: (prev, next) =>
              prev.status != StopItStatus.finished &&
              next.status == StopItStatus.finished,
          listener: (context, state) {
            context.go(
              '/end-score',
              extra: EndScoreArgs(
                gameTitle: 'Stop It!',
                score: state.score.value,
                playRoute: '/stop-it',
              ),
            );
          },
        ),
        BlocListener<StopItBloc, StopItState>(
          listenWhen: (prev, next) =>
              prev.elapsedHundredths != next.elapsedHundredths &&
              next.status == StopItStatus.running,
          listener: (context, state) {
            if (state.elapsedHundredths % 100 == 0) {
              tickSfx.playSfx(
                'assets/sounds/tick_tick.mp3',
                volume: AudioLevels.tickSfxVolume,
              );
            }
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final bloc = context.read<StopItBloc>();
              if (bloc.state.status == StopItStatus.running) {
                bloc.add(const StopItStopped());
              } else if (bloc.state.status == StopItStatus.idle) {
                bloc.add(const StopItStarted());
              }
            },
            child: GamePageCard(
              title: 'STOP IT',
              onBack: () => context.go('/home'),
              // backgroundColor: AppColors.lightPurple,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<StopItBloc, StopItState>(
                      builder: (context, state) {
                        final targetSeconds =
                            (state.targetHundredths / 100).floor();
                        final targetDifference =
                            (state.targetHundredths - state.elapsedHundredths)
                                .abs();
                        final timeGlow = targetDifference <= 300 &&
                                state.status == StopItStatus.running
                            ? AppColors.danger
                            : const Color(0xFFF2F2F2);
                        final elapsedHundredths = state.elapsedHundredths;
                        final elapsedSeconds =
                            (elapsedHundredths / 100).floor();
                        final elapsedRemainder = elapsedHundredths % 100;

                        final targetDisplay = '${targetSeconds}:00';
                        final elapsedDisplay =
                            '${elapsedSeconds}:${elapsedRemainder.toString().padLeft(2, '0')}';
                        return IntrinsicWidth(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LedDisplayPanel(
                                label: 'TARGET',
                                value: targetDisplay,
                                glowColor: const Color(0xFFF2F2F2),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              LedDisplayPanel(
                                label: 'TIME',
                                value: elapsedDisplay,
                                glowColor: timeGlow,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    BlocBuilder<StopItBloc, StopItState>(
                      builder: (context, state) {
                        final text = state.status == StopItStatus.running
                            ? 'Press anywhere to stop'
                            : 'Press anywhere to start';
                        return Text(
                          text,
                          style: AppTextStyles.bodySecondary,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
