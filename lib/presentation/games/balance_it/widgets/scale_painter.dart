import 'package:flutter/material.dart';

class ScalePainter extends CustomPainter {
  static const int maxValue = 50;

  final double plankHeight;

  const ScalePainter({required this.plankHeight});

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
    final baseY = size.height - (plankHeight * 0.25);

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

    }
  }

  @override
  bool shouldRepaint(covariant ScalePainter oldDelegate) =>
      oldDelegate.plankHeight != plankHeight;
}

class ScaleLabels extends StatelessWidget {
  final double plankHeight;

  const ScaleLabels({super.key, required this.plankHeight});

  @override
  Widget build(BuildContext context) {
    const values = [-50, -40, -30, -20, -10, 0, 10, 20, 30, 40, 50];
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final centerX = width / 2;
        final topY = 0.0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final value in values)
              _ScaleLabel(
                value: value,
                left:
                    centerX + (value / ScalePainter.maxValue) * width * 0.48,
                top: topY,
              ),
          ],
        );
      },
    );
  }
}

class _ScaleLabel extends StatelessWidget {
  final int value;
  final double left;
  final double top;

  const _ScaleLabel({
    required this.value,
    required this.left,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    final isCenter = value == 0;
    final textStyle = TextStyle(
      color: Colors.brown.shade900,
      fontSize: isCenter ? 12 : 11,
      fontWeight: isCenter ? FontWeight.w700 : FontWeight.w600,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: value.toString(), style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    return Positioned(
      left: left - textPainter.width / 2,
      top: top,
      child: Text(
        value.toString(),
        style: textStyle,
      ),
    );
  }
}
