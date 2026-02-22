import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class JarFill extends StatelessWidget {
  final double progress;
  final int targetValue;

  const JarFill({
    super.key,
    required this.progress,
    required this.targetValue,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return SizedBox(
      width: 220,
      height: 420,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 18,
            right: 18,
            top: 24,
            bottom: 20,
            child: CustomPaint(
              painter: _BeakerMarkingsPainter(targetValue: targetValue),
            ),
          ),
          Positioned(
            left: 30,
            right: 40,
            top: 34,
            bottom: 34,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.75),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(-4, -6),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0x55FFFFFF), Color(0x11FFFFFF)],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          curve: Curves.easeOut,
                          width: double.infinity,
                          height: constraints.maxHeight * clamped,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2EC6FF),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 16,
                  bottom: 16,
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BeakerMarkingsPainter extends CustomPainter {
  final int targetValue;

  _BeakerMarkingsPainter({required this.targetValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paintMajor = Paint()
      ..color = AppColors.black.withOpacity(0.55)
      ..strokeWidth = 2;
    final paintMinor = Paint()
      ..color = AppColors.black.withOpacity(0.3)
      ..strokeWidth = 1.5;

    final textStyle = TextStyle(
      color: AppColors.black.withOpacity(0.75),
      fontSize: 10,
      fontWeight: FontWeight.w600,
    );

    final targetStyle = const TextStyle(
      color: Colors.black,
      fontSize: 11,
      fontWeight: FontWeight.w700,
    );

    const total = 100;
    const step = 5;
    const topPad = 20.0;
    const bottomPad = 20.0;
    final usableHeight = size.height - topPad - bottomPad;
    final tickCount = total ~/ step;
    for (int i = 0; i <= tickCount; i++) {
      final value = i * step;
      final y =
          topPad + (usableHeight * (1 - (value / total)));
      final isMajor = value % 10 == 0;
      final tickLength = isMajor ? 18.0 : 10.0;
      final paint = isMajor ? paintMajor : paintMinor;

      canvas.drawLine(
        Offset(size.width - tickLength, y),
        Offset(size.width, y),
        paint,
      );

      if (isMajor && value != 0) {
        final textPainter = TextPainter(
          text: TextSpan(text: '$value', style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(size.width - tickLength - textPainter.width - 6, y - 6),
        );
      }
    }

    final targetY = topPad + (usableHeight * (1 - (targetValue / total)));
    final targetPainter = TextPainter(
      text: TextSpan(text: '$targetValue', style: targetStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.drawLine(
      Offset(0, targetY),
      Offset(size.width, targetY),
      Paint()
        ..color = Colors.black.withOpacity(0.6)
        ..strokeWidth = 2,
    );
    targetPainter.paint(
      canvas,
      Offset(6, targetY - 7),
    );
  }

  @override
  bool shouldRepaint(covariant _BeakerMarkingsPainter oldDelegate) =>
      oldDelegate.targetValue != targetValue;
}
