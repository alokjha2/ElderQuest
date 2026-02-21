import 'package:elder_quest/application/games/tapme/tapme_bloc.dart';
import 'package:elder_quest/application/games/tapme/tapme_event.dart';
import 'package:elder_quest/application/games/tapme/tapme_state.dart';
import 'package:elder_quest/domain/games/tapme/tapme_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../shared/end_score/end_score_page.dart';

class TapMePage extends StatelessWidget {
  const TapMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TapMeView();
  }
}

class _TapMeView extends HookWidget {
  const _TapMeView();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<TapMeBloc>().add(TapMeReset());
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<TapMeBloc, TapMeState>(
        listenWhen: (prev, curr) => prev.game.status != curr.game.status,
        listener: (context, state) {
          if (state.game.status == TapMeStatus.finished) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EndScorePage(
                  gameTitle: 'Tap Me!',
                  score: state.game.score.value,
                  playRoute: '/tapme',
                ),
              ),
            );
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
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
          },
          child: Center(
            child: BlocBuilder<TapMeBloc, TapMeState>(
              builder: (context, state) {
                final game = state.game;
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
        ),
      ),
    );
  }
}
