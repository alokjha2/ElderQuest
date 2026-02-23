import 'package:elder_quest/application/games/tapme/tapme_bloc.dart';
import 'package:elder_quest/application/games/tapme/tapme_event.dart';
import 'package:elder_quest/application/games/tapme/tapme_state.dart';
import 'package:elder_quest/core/audio/app_sounds.dart';
import 'package:elder_quest/core/audio/audio_levels.dart';
import 'package:elder_quest/core/audio/game_audio_player.dart';
import 'package:elder_quest/domain/games/tapme/tapme_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/audio/audio_service.dart';
import '../../../../core/component/game_page_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../shared/end_score/end_score_page.dart';
import 'tap_burst.dart';

class TapMeViewBody extends StatefulWidget {
  const TapMeViewBody({super.key});

  @override
  State<TapMeViewBody> createState() => _TapMeViewBodyState();
}

class _TapMeViewBodyState extends State<TapMeViewBody>
    with TickerProviderStateMixin {
  final List<TapBurst> _bursts = [];
  final GlobalKey _bodyKey = GlobalKey();
  late final GameAudioPlayer _tapSfxPlayer;
  late final GameAudioPlayer _tickSfxPlayer;

  @override
  void initState() {
    super.initState();
    _tapSfxPlayer = GameAudioPlayer();
    _tickSfxPlayer = GameAudioPlayer();
    AudioService.instance
        .setBackgroundVolume(AudioService.gameplayBackgroundVolume);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TapMeBloc>().add(TapMeReset());
    });
  }

  @override
  void dispose() {
    _tapSfxPlayer.dispose();
    _tickSfxPlayer.dispose();
    for (final burst in _bursts) {
      burst.controller.dispose();
    }
    _bursts.clear();
    super.dispose();
  }

  void _addBurst(Offset position) {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    final burst = TapBurst(position: position, controller: controller);
    setState(() => _bursts.add(burst));
    controller.forward().whenComplete(() {
      if (!mounted) return;
      setState(() => _bursts.remove(burst));
      controller.dispose();
    });
  }

  void _handleTap(Offset globalPosition) {
    final box = _bodyKey.currentContext?.findRenderObject() as RenderBox?;
    final localPosition =
        box != null ? box.globalToLocal(globalPosition) : globalPosition;
    _addBurst(localPosition);
    _tapSfxPlayer.playSfx(
      AppSounds.tap,
      volume: AudioLevels.tapSfxVolume,
    );
    final bloc = context.read<TapMeBloc>();
    final status = bloc.state.game.status;
    if (status == TapMeStatus.initial) {
      bloc.add(TapMeStarted());
      bloc.add(TapMeTapped());
      return;
    }
    if (status == TapMeStatus.playing) {
      bloc.add(TapMeTapped());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TapMeBloc, TapMeState>(
          listenWhen: (prev, curr) => prev.game.status != curr.game.status,
          listener: (context, state) {
            if (state.game.status == TapMeStatus.finished) {
              context.go(
                '/end-score',
                extra: EndScoreArgs(
                  gameTitle: 'Tap Me!',
                  score: state.game.score.value,
                  playRoute: '/tapme',
                ),
              );
            }
          },
        ),
        BlocListener<TapMeBloc, TapMeState>(
          listenWhen: (prev, curr) =>
              prev.game.remainingTime != curr.game.remainingTime &&
              curr.game.status == TapMeStatus.playing,
          listener: (context, state) {
            _tickSfxPlayer.playSfx(
              AppSounds.tick,
              volume: AudioLevels.tickSfxVolume,
            );
          },
        ),
      ],
      child: GamePageCard(
        backgroundColor: AppColors.hintBlue,
        title: 'TAP ME',
        onBack: () => context.pop(),
        onTapDown: (details) => _handleTap(details.globalPosition),
        body: Stack(
          key: _bodyKey,
          children: [
            Center(
              child: BlocBuilder<TapMeBloc, TapMeState>(
                builder: (context, state) {
                  final game = state.game;
                  final timeColor = game.remainingTime <= 3 &&
                          game.status == TapMeStatus.playing
                      ? AppColors.danger
                      : AppTextStyles.scoreText.color;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Time: ${game.remainingTime}',
                        style: AppTextStyles.scoreText.copyWith(
                          color: timeColor,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s20),
                      Text(
                        'Score: ${game.score.value}',
                        style: AppTextStyles.scoreText,
                      ),
                      const SizedBox(height: AppSpacing.s40),
                      Text(
                        game.status == TapMeStatus.initial
                            ? 'Tap anywhere to start'
                            : 'Tap anywhere',
                        style: AppTextStyles.bodySecondary,
                      ),
                    ],
                  );
                },
              ),
            ),
            ..._bursts.map((burst) => TapBurstView(burst: burst)),
          ],
        ),
      ),
    );
  }
}
