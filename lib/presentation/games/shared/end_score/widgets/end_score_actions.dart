import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';

class EndScoreActions extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onExit;
  final VoidCallback onAgain;

  const EndScoreActions({
    super.key,
    required this.onShare,
    required this.onExit,
    required this.onAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ActionText(label: 'Share', onTap: onShare),
        _ActionText(label: 'Exit', onTap: onExit),
        _ActionText(label: 'Again', onTap: onAgain),
      ],
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
