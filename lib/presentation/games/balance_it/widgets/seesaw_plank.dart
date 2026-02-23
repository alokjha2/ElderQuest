import 'package:flutter/material.dart';

class SeesawPlank extends StatelessWidget {
  final double width;
  final double height;

  const SeesawPlank({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(width, height),
          painter: _PlankShadowPainter(),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height * 0.5),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD9A066),
                Color(0xFFB9793F),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlankShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.14)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 + 8),
      width: size.width * 0.98,
      height: size.height * 0.9,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(size.height * 0.4)),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PlankShadowPainter oldDelegate) => false;
}
