import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../application/games/hold_it/hold_it_bloc.dart';
import '../../../application/games/hold_it/hold_it_event.dart';
import '../../../application/games/hold_it/hold_it_state.dart';
import '../../../domain/games/hold_it/hold_it_game.dart';
import '../../../domain/games/hold_it/hold_it_status.dart';
import '../shared/end_score_page.dart';
import 'widgets/hold_button.dart';
import 'widgets/progress_indicator.dart';
import 'widgets/score_text.dart';

class HoldItPage extends HookWidget {
  const HoldItPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HoldItBloc(),
      child: BlocListener<HoldItBloc, HoldItState>(
        listenWhen: (prev, next) =>
            prev.status != next.status &&
            (next.status == HoldItStatus.success ||
                next.status == HoldItStatus.fail),
        listener: (context, state) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EndScorePage(
                modeTitle: 'Hold It!',
                score: state.score.value,
                onAgain: () {
                  Navigator.of(context).pop();
                  context.read<HoldItBloc>().add(const ResetHoldEvent());
                },
              ),
            ),
          );
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF4FAFF),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: BlocBuilder<HoldItBloc, HoldItState>(
                  builder: (context, state) {
                    final progress = state.heldMs / HoldItGame.maxMs;
                    final isHolding = state.status == HoldItStatus.holding;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScoreText(score: state.score.value),
                        const SizedBox(height: 16),
                        HoldProgressIndicator(progress: progress),
                        const SizedBox(height: 32),
                        HoldButton(
                          isHolding: isHolding,
                          onPressed: () => context
                              .read<HoldItBloc>()
                              .add(const StartHoldEvent()),
                          onReleased: () => context
                              .read<HoldItBloc>()
                              .add(const ReleaseHoldEvent()),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
