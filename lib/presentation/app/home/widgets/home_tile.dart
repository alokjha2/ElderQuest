import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  final Color color;
  final Color textColor;

  const HomeTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(AppSpacing.s20),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSpacing.s28),
          border: Border.all(
            color: AppColors.white.withOpacity(0.35),
            width: AppSpacing.xs,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.tileTitle.copyWith(color: textColor),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      height: AppSpacing.xs,
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(AppSpacing.s18),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: AppSpacing.sm),
              // Text(subtitle, style: AppTextStyles.tileSubtitle),
            ],
          ),
        ),
      ),
    );
  }
}
