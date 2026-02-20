import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class EndScorePage extends HookWidget {
  final String modeTitle;
  final int score;
  final String bestLabel;
  final VoidCallback? onShare;
  final VoidCallback? onExit;
  final VoidCallback? onAgain;

  const EndScorePage({
    super.key,
    required this.modeTitle,
    required this.score,
    this.bestLabel = 'DAILY BEST',
    this.onShare,
    this.onExit,
    this.onAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Expanded(
                    child: Text(
                      "Piano Tiles (Don't tap the white tile)",
                      style: AppTextStyles.endScoreHeader,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text('1795', style: AppTextStyles.endScoreHeaderValue),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.music_note,
                      color: AppColors.white, size: AppSpacing.s18),
                ],
              ),
              const SizedBox(height: AppSpacing.s36),
              Text('5 x 5', style: AppTextStyles.endScoreModeMeta),
              const SizedBox(height: AppSpacing.md),
              Text(modeTitle, style: AppTextStyles.endScoreModeTitle),
              const SizedBox(height: AppSpacing.s32),
              Text('$score', style: AppTextStyles.endScoreValue),
              const SizedBox(height: AppSpacing.s32),
              Text(bestLabel, style: AppTextStyles.endScoreBest),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionText(label: 'Share', onTap: onShare),
                  _ActionText(
                    label: 'Exit',
                    onTap: onExit ?? () => Navigator.of(context).maybePop(),
                  ),
                  _ActionText(label: 'Again', onTap: onAgain),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
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
