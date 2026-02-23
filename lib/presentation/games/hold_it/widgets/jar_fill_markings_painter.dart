import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class JarFillMarkingsPainter extends CustomPainter {
  final int targetValue;

  JarFillMarkingsPainter({required this.targetValue});

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
      final y = topPad + (usableHeight * (1 - (value / total)));
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
  bool shouldRepaint(covariant JarFillMarkingsPainter oldDelegate) =>
      oldDelegate.targetValue != targetValue;
}
