import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class JarFill extends StatelessWidget {
  final double progress;

  const JarFill({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 90,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white.withOpacity(0.8), width: 3),
              borderRadius: BorderRadius.circular(18),
              color: Colors.transparent,
            ),
          ),
          Positioned(
            bottom: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 82,
                height: 142,
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeOut,
                  width: double.infinity,
                  height: (142 * progress.clamp(0.0, 1.0)),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2EC6FF),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
