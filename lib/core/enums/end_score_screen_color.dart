import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum EndScoreScreenColor {
  red(AppColors.endScoreRed),
  blue(AppColors.endScoreBlue),
  green(AppColors.endScoreGreen),
  purple(AppColors.endScorePurple);

  final Color color;
  const EndScoreScreenColor(this.color);
}