import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_back_button.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const Header({
    super.key,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBackButton(onTap: onBack),
        const SizedBox(width: AppSpacing.md),
        Text(
          title,
          style: AppTextStyles.tileTitle.copyWith(
            color: AppColors.white,
            fontSize: 30,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
