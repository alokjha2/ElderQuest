import 'package:flutter/material.dart';

class SeesawBase extends StatelessWidget {
  final double width;
  final double height;

  const SeesawBase({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _SeesawBasePainter(),
    );
  }
}

class _SeesawBasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final basePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFB87333),
          Color(0xFF9B5C2E),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawShadow(path, Colors.black.withOpacity(0.25), 6, false);
    canvas.drawPath(path, basePaint);
  }

  @override
  bool shouldRepaint(covariant _SeesawBasePainter oldDelegate) => false;
}
