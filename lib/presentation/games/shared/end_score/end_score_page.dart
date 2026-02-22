import 'dart:io';
import 'dart:typed_data';

import 'package:elder_quest/core/component/game_page_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'widgets/end_score_actions.dart';
import 'widgets/end_score_header.dart';
import 'widgets/end_score_summary.dart';

class EndScorePage extends HookWidget {
  final String gameTitle;
  final int score;
  final String bestLabel;
  final String playRoute;

  const EndScorePage({
    super.key,
    required this.gameTitle,
    required this.score,
    required this.playRoute,
    this.bestLabel = 'DAILY BEST',
  });

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => ScreenshotController());
    final isSharing = useState(false);

    Future<void> shareScore() async {
      if (isSharing.value) return;
      isSharing.value = true;
      try {
        final Uint8List? bytes = await controller.capture();
        if (bytes == null) return;
        final dir = await Directory.systemTemp.createTemp('elderquest');
        final file = File('${dir.path}/score.png');
        await file.writeAsBytes(bytes);
        await Share.shareXFiles(
          [XFile(file.path)],
          text: '$gameTitle Score: $score',
        );
      } finally {
        isSharing.value = false;
      }
    }

    return Screenshot(
      controller: controller,
      child: GamePageCard(
        bodypadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s28, vertical: AppSpacing.s16),
        backgroundColor: AppColors.endScoreRed,
       
          
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EndScoreSummary(
                gameTitle: gameTitle,
                score: score,
                bestLabel: bestLabel,
              ),
              const Spacer(),
              EndScoreActions(
                onShare: shareScore,
                onExit: () => context.go('/home'),
                onAgain: () => context.go(playRoute),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ), title: "", onBack: () => context.go('/home'),
      ),
    );
  }
}
