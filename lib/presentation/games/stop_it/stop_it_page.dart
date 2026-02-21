import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../application/games/stop_it/stop_it_bloc.dart';
import '../../../application/games/stop_it/stop_it_event.dart';
import '../../../application/games/stop_it/stop_it_state.dart';
import '../../../domain/games/stop_it/stop_it_status.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../shared/end_score/end_score_page.dart';

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
      child: Scaffold(
        backgroundColor: AppColors.lightPurple,
        body: SafeArea(
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
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.s24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => context.go('/home'),
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          const Text('Stop It!',
                              style: AppTextStyles.titleMedium),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s24),
                      BlocBuilder<StopItBloc, StopItState>(
                        builder: (context, state) {
                          final targetSeconds = (state.targetHundredths / 100)
                              .toStringAsFixed(0);
                          final currentSeconds = (state.elapsedHundredths / 100)
                              .toStringAsFixed(2);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Target: $targetSeconds s',
                                  style: AppTextStyles.scoreText),
                              const SizedBox(height: AppSpacing.s16),
                              Text('Time: $currentSeconds s',
                                  style: AppTextStyles.scoreText),
                            ],
                          );
                        },
                      ),
                      const Spacer(),
                      Center(
                        child: BlocBuilder<StopItBloc, StopItState>(
                          builder: (context, state) {
                            final text = state.status == StopItStatus.running
                                ? 'Press anywhere to stop'
                                : 'Press anywhere to start';
                            return Text(text,
                                style: AppTextStyles.bodySecondary);
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
