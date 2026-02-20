import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class HoldButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onReleased;
  final bool isHolding;

  const HoldButton({
    super.key,
    required this.onPressed,
    required this.onReleased,
    required this.isHolding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      onTapUp: (_) => onReleased(),
      onTapCancel: onReleased,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s44,
          vertical: AppSpacing.s20,
        ),
        decoration: BoxDecoration(
          color: isHolding ? AppColors.holdRed : AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.s24),
        ),
        child: Text(
          isHolding ? 'HOLDING...' : 'HOLD',
          style: AppTextStyles.tileTitle,
        ),
      ),
    );
  }
}
