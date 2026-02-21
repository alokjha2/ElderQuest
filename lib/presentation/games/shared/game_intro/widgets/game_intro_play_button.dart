import 'package:elder_quest/core/theme/app_colors.dart';
import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';

class GameIntroPlayButton extends StatelessWidget {
  final Color accent;
  final VoidCallback onPressed;

  const GameIntroPlayButton({
    super.key,
    required this.accent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s24,
        0,
        AppSpacing.s24,
        AppSpacing.s32,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.s16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('PLAY', style: AppTextStyles.buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
