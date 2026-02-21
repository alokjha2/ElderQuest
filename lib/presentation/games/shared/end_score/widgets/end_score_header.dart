import 'package:elder_quest/core/theme/app_colors.dart';
import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';

class EndScoreHeader extends StatelessWidget {
  final String gameTitle;
  final int score;
  final VoidCallback onBack;

  const EndScoreHeader({
    super.key,
    required this.gameTitle,
    required this.score,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            gameTitle.toUpperCase(),
            style: AppTextStyles.endScoreHeaderValue,
          ),
        ),
        Text('$score', style: AppTextStyles.endScoreHeaderValue),
      ],
    );
  }
}
