import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle appTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 1.1,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle hintBlink = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.hintBlue,
  );

  static const TextStyle tileTitle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle tileSubtitle = TextStyle(
    color: AppColors.white70,
  );

  static const TextStyle endScoreHeader = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle endScoreHeaderValue = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle endScoreModeMeta = TextStyle(
    color: AppColors.white70,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle endScoreModeTitle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle endScoreValue = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w800,
    fontSize: 88,
  );

  static const TextStyle endScoreBest = TextStyle(
    color: AppColors.black87,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  static const TextStyle endScoreAction = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle settingsTitle = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 20,
    letterSpacing: 1.2,
    color: AppColors.settingsTitle,
  );

  static const TextStyle settingsSection = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.settingsText,
  );

  static const TextStyle settingsFpsText = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 16,
    color: AppColors.settingsFpsText,
  );

  static const TextStyle settingsLanguage = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle settingsFooter = TextStyle(
    fontSize: 14,
    color: AppColors.settingsFooter,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle settingsFooterLink = TextStyle(
    color: AppColors.settingsThumb,
  );

  static const TextStyle timerValue = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle timerTarget = TextStyle(
    color: AppColors.textSecondary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle scoreText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextTheme textTheme(TextTheme base) {
    return base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }
}
