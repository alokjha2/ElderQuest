import 'package:elder_quest/application/games/tapme/tapme_bloc.dart';
import 'package:elder_quest/application/games/tapme/tapme_event.dart';
import 'package:elder_quest/application/games/tapme/tapme_state.dart';
import 'package:elder_quest/domain/games/tapme/tapme_status.dart';
import 'package:elder_quest/presentation/games/shared/end_score_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
                  child: const Text("Start"),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Time: ${game.remainingTime}",
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Score: ${game.score.value}",
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TapMeBloc>().add(TapMeTapped()),
                    child: const Text("TAP!"),
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