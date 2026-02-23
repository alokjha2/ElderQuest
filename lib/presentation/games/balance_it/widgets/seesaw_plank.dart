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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
        ),
        Positioned(
          top: height * 0.18,
          child: Container(
            width: width * 0.9,
            height: height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(height * 0.2),
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
      ..color = Colors.black.withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 + 6),
      width: size.width * 0.95,
      height: size.height * 0.8,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(size.height * 0.4)),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _PlankShadowPainter oldDelegate) => false;
}
