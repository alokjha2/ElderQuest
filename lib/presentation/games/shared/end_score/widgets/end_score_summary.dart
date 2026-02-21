import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';

class EndScoreSummary extends StatelessWidget {
  final String gameTitle;
  final int score;
  final String bestLabel;

  const EndScoreSummary({
    super.key,
    required this.gameTitle,
    required this.score,
    required this.bestLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(gameTitle, style: AppTextStyles.endScoreModeTitle),
        const SizedBox(height: AppSpacing.s32),
        Text('$score', style: AppTextStyles.endScoreValue),
        const SizedBox(height: AppSpacing.s32),
        Text(bestLabel, style: AppTextStyles.endScoreBest),
      ],
    );
  }
}
