import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/component/game_page_card.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import 'balance_it_animator.dart';
import 'balance_it_utils.dart';
import 'widgets/balance_it_board.dart';
import '../shared/end_score/end_score_page.dart';

class BalanceItPage extends HookWidget {
  const BalanceItPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    );
    final animator = useMemoized(
      () => BalanceItAnimator(controller: controller),
      [controller],
    );
    final animatedBall = useAnimation(animator.ballAnimation);
    final isGameEnded = useState(false);
    final frozenBallPosition = useState(0.0);
    final targetValue = useMemoized(randomTargetValue);

    useEffect(() {
      AudioService.instance
          .setBackgroundVolume(AudioService.gameplayBackgroundVolume);
      controller.repeat(reverse: true);
      return () {
        controller.stop();
      };
    }, [controller]);

    final ballPosition =
        isGameEnded.value ? frozenBallPosition.value : animatedBall;
    final tiltRadians = animator.tiltFor(ballPosition);

    return GamePageCard(
      title: 'BALANCE IT',
      // backgroundColor: const Color(0xFFF5F5F5),
      onBack: () => context.pop(),
      onTapDown: (_) {
        if (isGameEnded.value) return;
        frozenBallPosition.value = animatedBall;
        isGameEnded.value = true;
        controller.stop();
        final score = _calculateScore(
          targetValue,
          frozenBallPosition.value,
        );
        context.go(
          '/end-score',
          extra: EndScoreArgs(
            gameTitle: 'Balance It!',
            score: score,
            playRoute: '/balance-it',
          ),
        );
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        child: Column(
          children: [
            Text(
              'TARGET: $targetValue',
              style: AppTextStyles.scoreText,
            ),
            const SizedBox(height: AppSpacing.s16),
            Expanded(
              child: Center(
                child: BalanceItBoard(
                  ballPosition: ballPosition,
                  tiltRadians: tiltRadians,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            Text(
              isGameEnded.value ? 'Game ended' : 'Press anywhere to stop',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: AppSpacing.s20),
          ],
        ),
      ),
    );
  }
}

int _calculateScore(int target, double position) {
  final difference = (position - target).abs();
  final score = (100 - (difference * 3)).round();
  return score.clamp(0, 100);
}
