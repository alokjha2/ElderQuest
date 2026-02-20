import 'package:elder_quest/application/games/tapme/tapme_bloc.dart';
import 'package:elder_quest/application/games/tapme/tapme_event.dart';
import 'package:elder_quest/application/games/tapme/tapme_state.dart';
import 'package:elder_quest/domain/games/tapme/tapme_status.dart';
import 'package:elder_quest/presentation/games/shared/end_score_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class TapMePage extends StatelessWidget {
  const TapMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TapMeBloc(),
      child: const _TapMeView(),
    );
  }
}

class _TapMeView extends StatelessWidget {
  const _TapMeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<TapMeBloc, TapMeState>(
        listenWhen: (prev, curr) =>
            prev.game.status != curr.game.status,
        listener: (context, state) {
          if (state.game.status == TapMeStatus.finished) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EndScorePage(
                  score: state.game.score.value,
                  modeTitle: 'Tap Me',
                ),
              ),
            );
          }
        },
        child: Center(
          child: BlocBuilder<TapMeBloc, TapMeState>(
            builder: (context, state) {
              final game = state.game;

              if (game.status == TapMeStatus.initial) {
                return ElevatedButton(
                  onPressed: () =>
                      context.read<TapMeBloc>().add(TapMeStarted()),
                  child: const Text('Start', style: AppTextStyles.buttonLabel),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Time: ${game.remainingTime}",
                    style: AppTextStyles.scoreText,
                  ),
                  const SizedBox(height: AppSpacing.s20),
                  Text(
                    "Score: ${game.score.value}",
                    style: AppTextStyles.scoreText,
                  ),
                  const SizedBox(height: AppSpacing.s40),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TapMeBloc>().add(TapMeTapped()),
                    child: const Text('TAP!', style: AppTextStyles.buttonLabel),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
