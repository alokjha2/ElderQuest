import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/audio/audio_levels.dart';
import '../../../core/audio/game_audio_player.dart';
import '../../../application/games/hold_it/hold_it_bloc.dart';
import '../../../application/games/hold_it/hold_it_event.dart';
import '../../../application/games/hold_it/hold_it_state.dart';
import '../../../domain/games/hold_it/hold_it_game.dart';
import '../../../domain/games/hold_it/hold_it_status.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/component/game_page_card.dart';
import '../shared/end_score/end_score_page.dart';
import 'widgets/jar_fill.dart';
import 'widgets/score_text.dart';

class HoldItPage extends HookWidget {
  const HoldItPage({super.key});

  @override
  Widget build(BuildContext context) {
    final waterSfx = useMemoized(GameAudioPlayer.new);
    useEffect(() {
      AudioService.instance
          .setBackgroundVolume(AudioService.gameplayBackgroundVolume);
      context.read<HoldItBloc>().add(const ResetHoldEvent());
      return () {
        waterSfx.dispose();
      };
    }, const []);

    return BlocListener<HoldItBloc, HoldItState>(
      listenWhen: (prev, next) =>
          prev.status != next.status &&
          (next.status == HoldItStatus.success ||
              next.status == HoldItStatus.fail),
      listener: (context, state) {
        context.go(
          '/end-score',
          extra: EndScoreArgs(
            gameTitle: 'Hold It!',
            score: state.score.value,
            playRoute: '/hold-it',
          ),
        );
      },
      child: Builder(
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) {
              waterSfx.playSfx(
                'assets/sounds/water_filling.mp3',
                volume: AudioLevels.waterSfxVolume,
                loop: true,
              );
              context.read<HoldItBloc>().add(const StartHoldEvent());
            },
            onTapUp: (_) {
              waterSfx.stopSfx();
              context.read<HoldItBloc>().add(const ReleaseHoldEvent());
            },
            onTapCancel: () {
              waterSfx.stopSfx();
              context.read<HoldItBloc>().add(const ReleaseHoldEvent());
            },
            child: BlocBuilder<HoldItBloc, HoldItState>(
              builder: (context, state) {
                final progress = state.heldMs / HoldItGame.maxMs;

                return GamePageCard(
                  title: 'HOLD IT',
                  onBack: () => context.pop(),
                  // backgroundColor: AppColors.lightBlue,
                  body: Column(
                    children: [
                      ScoreText(score: state.score.value),
                      const SizedBox(height: AppSpacing.s16),
                      JarFill(
                        progress: progress,
                        targetValue: state.targetValue,
                      ),
                      const SizedBox(height: AppSpacing.s32),
                      Text(
                        state.status == HoldItStatus.holding
                            ? 'Release to stop'
                            : 'Press anywhere to fill',
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
