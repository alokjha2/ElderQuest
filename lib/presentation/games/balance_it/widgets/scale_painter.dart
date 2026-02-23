import 'package:flutter/material.dart';

class ScalePainter extends CustomPainter {
  static const int maxValue = 50;

  @override
  void paint(Canvas canvas, Size size) {
    final tickPaint = Paint()
      ..color = Colors.brown.shade900.withOpacity(0.75)
      ..strokeWidth = 2;
    final minorPaint = Paint()
      ..color = Colors.brown.shade900.withOpacity(0.55)
      ..strokeWidth = 1.4;
    final tinyPaint = Paint()
      ..color = Colors.brown.shade900.withOpacity(0.4)
      ..strokeWidth = 1;

    final centerX = size.width / 2;
    final topY = 0.0;
    final baseY = size.height * 0.35;

    for (int i = -maxValue; i <= maxValue; i++) {
      final x = centerX + (i / maxValue) * size.width * 0.48;
      final isMajor = i % 10 == 0;
      final isMid = i % 5 == 0;
      final length = isMajor
          ? size.height * 0.35
          : isMid
              ? size.height * 0.25
              : size.height * 0.18;
      final paint = isMajor
          ? tickPaint
          : isMid
              ? minorPaint
              : tinyPaint;
      canvas.drawLine(
        Offset(x, baseY),
        Offset(x, baseY - length),
        paint,
      );

      if (isMajor && i != 0) {
        _drawLabel(
          canvas,
          size,
          label: i.toString(),
          position: Offset(x, topY),
        );
      }
      if (i == 0) {
        _drawLabel(
          canvas,
          size,
          label: '0',
          position: Offset(x, topY),
          isCenter: true,
        );
      }
    }
  }

  void _drawLabel(
    Canvas canvas,
    Size size, {
    required String label,
    required Offset position,
    bool isCenter = false,
  }) {
    final textStyle = TextStyle(
      color: Colors.brown.shade900,
      fontSize: isCenter ? 12 : 11,
      fontWeight: isCenter ? FontWeight.w700 : FontWeight.w600,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(position.dx - textPainter.width / 2, position.dy),
    );
  }

  @override
  bool shouldRepaint(covariant ScalePainter oldDelegate) => false;
}
