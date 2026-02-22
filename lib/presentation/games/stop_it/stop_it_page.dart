import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

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
    useEffect(() {
      context.read<StopItBloc>().add(const StopItReset());
      return null;
    }, const []);

    return BlocListener<StopItBloc, StopItState>(
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
              body: Column(
                children: [
                  BlocBuilder<StopItBloc, StopItState>(
                    builder: (context, state) {
                      final targetSeconds =
                          (state.targetHundredths / 100).floor();
                      final remaining = (state.maxHundredths -
                              state.elapsedHundredths)
                          .clamp(0, state.maxHundredths) as int;
                      final remainingSeconds = (remaining / 100).floor();
                      final remainingHundredths = remaining % 100;

                      final targetDisplay = '${targetSeconds}:00';
                      final remainingDisplay =
                          '${remainingSeconds}:${remainingHundredths.toString().padLeft(2, '0')}';
                      return Column(
                        children: [
                          LedDisplayPanel(
                            label: 'TARGET',
                            value: targetDisplay,
                            glowColor: const Color(0xFFF2F2F2),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          LedDisplayPanel(
                            label: 'TIME',
                            value: remainingDisplay,
                            glowColor: const Color(0xFFF2F2F2),
                          ),
                        ],
                      );
                    },
                  ),
                  const Spacer(),
                  BlocBuilder<StopItBloc, StopItState>(
                    builder: (context, state) {
                      final text = state.status == StopItStatus.running
                          ? 'Press anywhere to stop'
                          : 'Press anywhere to start';
                      return Center(
                        child: Text(text, style: AppTextStyles.bodySecondary),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
