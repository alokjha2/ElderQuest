import 'package:elder_quest/core/component/app_back_button.dart';
import 'package:elder_quest/core/component/header.dart';
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
        AppSpacing.xl,
        AppSpacing.s48,
        AppSpacing.xl,
        AppSpacing.s16,
      ),
      decoration: BoxDecoration(color: topBar),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Header(title: title, onBack: onBack),
          
          const SizedBox(height: AppSpacing.s18),
          Text(
            description,
            // textAlign: TextAlign.center,
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
