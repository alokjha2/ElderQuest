import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_back_button.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final bool underline;

  const Header({
    super.key,
    required this.title,
    required this.onBack,
    this.underline = true,
  });

  @override
Widget build(BuildContext context) {
  final textStyle = AppTextStyles.tileTitle.copyWith(
    color: AppColors.white,
    fontSize: 30,
    letterSpacing: 1.2,
  );

  final textPainter = TextPainter(
    text: TextSpan(text: title, style: textStyle),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  final textWidth = textPainter.width + 10;

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppBackButton(onTap: onBack),
      const SizedBox(width: AppSpacing.md),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          ?underline
              ?
          Container(
            height: 4,
            width: textWidth,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          ) : null,
        ],
      ),
    ],
  );
}
}
