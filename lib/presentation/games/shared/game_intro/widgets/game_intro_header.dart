import 'package:elder_quest/core/theme/app_colors.dart';
import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';

class GameIntroHeader extends StatelessWidget {
  final String title;
  final String description;
  final Color topBar;
  final VoidCallback onBack;

  const GameIntroHeader({
    super.key,
    required this.title,
    required this.description,
    required this.topBar,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s18,
        AppSpacing.s56,
        AppSpacing.s16,
        AppSpacing.s16,
      ),
      decoration: BoxDecoration(color: topBar),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Text(
                title,
                style: AppTextStyles.tileTitle.copyWith(
                  color: AppColors.white,
                  fontSize: 30,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s18),
          Text(
            description,
            style: AppTextStyles.bodySecondary.copyWith(
              color: AppColors.white70,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
