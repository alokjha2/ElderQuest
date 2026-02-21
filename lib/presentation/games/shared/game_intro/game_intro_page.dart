import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'level_config.dart';
import 'widgets/game_intro_difficulty.dart';
import 'widgets/game_intro_header.dart';
import 'widgets/game_intro_play_button.dart';

class GameIntroPage extends HookWidget {
  final String title;
  final String description;
  final String playRoute;
  final Color accent;
  final Color topBar;

  const GameIntroPage({
    super.key,
    required this.title,
    required this.description,
    required this.playRoute,
    required this.accent,
    required this.topBar,
  });

  factory GameIntroPage.forGame(String game) {
    switch (game) {
      case 'tapme':
        return const GameIntroPage(
          title: 'TAP ME!',
          description:
    ' – Tap as fast as you can to score higher.\n\n'
    ' – The highest score so far is 129. Can you beat it?',
          playRoute: '/tapme',
          accent: AppColors.primary,
          topBar: Color(0xFF3B2E54),
        );
      case 'stop-it':
        return const GameIntroPage(
          title: 'STOP IT!',
          
          description:
            'Press Start and Stop as close to the target time as possible. \n \n'
            'Only 1 out of 33 people can get 100 score in the game. Can you be one of them?',
          playRoute: '/stop-it',
          accent: AppColors.accent,
          topBar: Color(0xFF3B2E54),
        );
      case 'hold-it':
        return const GameIntroPage(
          title: 'HOLD IT!',
          description:
    'Hold until the jar fills, but don\'t let it overflow.\n\n'
    'You need Arjun-level precision to score 100 in this game. Do you have what it takes?',
          playRoute: '/hold-it',
          accent: AppColors.tileOrange,
          topBar: Color(0xFF3B2E54),
        );
      // case 'balance-it':
      //   return const GameIntroPage(
      //     title: 'BALANCE IT!',
      //     description: 'Keep it steady as long as you can.',
      //     playRoute: '/balance-it',
      //     accent: AppColors.tilePurple,
      //     topBar: Color(0xFF3B2E54),
      //   );
      default:
        return const GameIntroPage(
          title: 'GAME',
          description: 'Get ready to play.',
          playRoute: '/home',
          accent: AppColors.primary,
          topBar: Color(0xFF3B2E54),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final difficultyIndex = useState(1);
    final levelsFuture = useMemoized(loadLevelConfigs);
    final levelsSnapshot = useFuture(levelsFuture);

    final levels = levelsSnapshot.data ?? defaultLevelConfigs;

    return Scaffold(
      backgroundColor: const Color(0xFFF7E5D7),
      body: Column(
        children: [
          GameIntroHeader(
            title: title,
            description: description,
            topBar: topBar,
            onBack: () => context.pop(),
          ),
          const SizedBox(height: AppSpacing.s24),
          GameIntroDifficulty(
            index: difficultyIndex.value,
            levels: levels,
            onChanged: (i) => difficultyIndex.value = i,
          ),
          const Spacer(),
          GameIntroPlayButton(
            accent: accent,
            onPressed: () => context.push(playRoute),
          ),
        ],
      ),
    );
  }
}
