import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import 'seven_segment_display.dart';

class LedDisplayPanel extends StatelessWidget {
  final String label;
  final String value;
  final Color glowColor;

  const LedDisplayPanel({
    super.key,
    required this.label,
    required this.value,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFB9BDC4),
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1E22),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF2B2F36), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2A2D33), Color(0xFF14161A)],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                SevenSegmentDisplay(
                  text: value,
                  color: glowColor,
                  offColor: const Color(0xFF2C2F35),
                  digitWidth: 34,
                  digitHeight: 62,
                  thickness: 6,
                  spacing: 6,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
