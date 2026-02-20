import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

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
      child: Scaffold(
        backgroundColor: AppColors.endScoreRed,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s28,
              vertical: AppSpacing.s16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/home'),
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.white),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        gameTitle.toUpperCase(),
                        style: AppTextStyles.endScoreHeaderValue,
                      ),
                    ),
                    Text(
                      '$score',
                      style: AppTextStyles.endScoreHeaderValue,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s36),
                Text(
                  gameTitle,
                  style: AppTextStyles.endScoreModeTitle,
                ),
                const SizedBox(height: AppSpacing.s32),
                Text('$score', style: AppTextStyles.endScoreValue),
                const SizedBox(height: AppSpacing.s32),
                Text(bestLabel, style: AppTextStyles.endScoreBest),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ActionText(label: 'Share', onTap: shareScore),
                    _ActionText(
                      label: 'Exit',
                      onTap: () => context.go('/home'),
                    ),
                    _ActionText(
                      label: 'Again',
                      onTap: () => context.go(playRoute),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionText extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _ActionText({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Text(label, style: AppTextStyles.endScoreAction),
      ),
    );
  }
}
