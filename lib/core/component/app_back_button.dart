import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const AppBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
        ),
      ),
    );
  }
}
