import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class HoldProgressIndicator extends StatelessWidget {
  final double progress;

  const HoldProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.xl),
      child: LinearProgressIndicator(
        minHeight: AppSpacing.xl,
        value: progress.clamp(0.0, 1.0),
        backgroundColor: AppColors.lightBlueFill,
        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }
}
