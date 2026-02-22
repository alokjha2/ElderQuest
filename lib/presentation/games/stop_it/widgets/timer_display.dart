import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class TimerDisplay extends StatelessWidget {
  final int elapsedHundredths;
  final int targetHundredths;

  const TimerDisplay({
    super.key,
    required this.elapsedHundredths,
    required this.targetHundredths,
  });

  String _format(int hundredths) {
    final seconds = hundredths ~/ 100;
    final fraction = hundredths % 100;
    final secStr = seconds.toString().padLeft(2, '0');
    final fracStr = fraction.toString().padLeft(2, '0');
    return '$secStr.$fracStr';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_format(elapsedHundredths), style: AppTextStyles.timerValue),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Target ${_format(targetHundredths)}',
          style: AppTextStyles.timerTarget,
        ),
      ],
    );
  }
}
