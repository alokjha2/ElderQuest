import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class SliderRow extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const SliderRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: AppSpacing.md,
        activeTrackColor: AppColors.settingsTrackActive,
        inactiveTrackColor: AppColors.settingsTrackInactive,
        thumbColor: AppColors.settingsThumb,
        overlayColor: AppColors.settingsThumb.withOpacity(0.2),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
