import 'package:flutter/material.dart';

class SevenSegmentDisplay extends StatelessWidget {
  final String text;
  final Color color;
  final Color offColor;
  final double digitWidth;
  final double digitHeight;
  final double thickness;
  final double spacing;

  const SevenSegmentDisplay({
    super.key,
    required this.text,
    required this.color,
    this.offColor = const Color(0xFF2A2A2A),
    this.digitWidth = 36,
    this.digitHeight = 64,
    this.thickness = 6,
    this.spacing = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: text.split('').map((char) {
        if (char == ':') {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: _SevenSegmentColon(
              color: color,
              size: thickness,
              height: digitHeight,
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: _SevenSegmentDigit(
            value: char,
            color: color,
            offColor: offColor,
            width: digitWidth,
            height: digitHeight,
            thickness: thickness,
          ),
        );
      }).toList(),
    );
  }
}

class _SevenSegmentDigit extends StatelessWidget {
  final String value;
  final Color color;
  final Color offColor;
  final double width;
  final double height;
  final double thickness;

  const _SevenSegmentDigit({
    required this.value,
    required this.color,
    required this.offColor,
    required this.width,
    required this.height,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _SevenSegmentPainter(
        segments: _digitSegments(value),
        color: color,
        offColor: offColor,
        thickness: thickness,
      ),
    );
  }

  List<bool> _digitSegments(String digit) {
    switch (digit) {
      case '0':
        return [true, true, true, true, true, true, false];
      case '1':
        return [false, true, true, false, false, false, false];
      case '2':
        return [true, true, false, true, true, false, true];
      case '3':
        return [true, true, true, true, false, false, true];
      case '4':
        return [false, true, true, false, false, true, true];
      case '5':
        return [true, false, true, true, false, true, true];
      case '6':
        return [true, false, true, true, true, true, true];
      case '7':
        return [true, true, true, false, false, false, false];
      case '8':
        return [true, true, true, true, true, true, true];
      case '9':
        return [true, true, true, true, false, true, true];
      default:
        return [false, false, false, false, false, false, false];
    }
  }
}

class _SevenSegmentColon extends StatelessWidget {
  final Color color;
  final double size;
  final double height;

  const _SevenSegmentColon({
    required this.color,
    required this.size,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.2,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(height: size * 1.2),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

class _SevenSegmentPainter extends CustomPainter {
  final List<bool> segments;
  final Color color;
  final Color offColor;
  final double thickness;

  _SevenSegmentPainter({
    required this.segments,
    required this.color,
    required this.offColor,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final w = size.width;
    final h = size.height;
    final t = thickness;

    Rect segA = Rect.fromLTWH(t, 0, w - 2 * t, t);
    Rect segD = Rect.fromLTWH(t, h - t, w - 2 * t, t);
    Rect segG = Rect.fromLTWH(t, (h - t) / 2, w - 2 * t, t);
    Rect segF = Rect.fromLTWH(0, t, t, (h - 3 * t) / 2);
    Rect segE = Rect.fromLTWH(0, (h + t) / 2, t, (h - 3 * t) / 2);
    Rect segB = Rect.fromLTWH(w - t, t, t, (h - 3 * t) / 2);
    Rect segC = Rect.fromLTWH(w - t, (h + t) / 2, t, (h - 3 * t) / 2);

    final segmentsRects = [segA, segB, segC, segD, segE, segF, segG];

    for (var i = 0; i < segmentsRects.length; i++) {
      if (segments[i]) {
        glowPaint.color = color.withOpacity(0.6);
        canvas.drawRRect(
          RRect.fromRectAndRadius(segmentsRects[i], Radius.circular(t / 2)),
          glowPaint,
        );
        paint.color = color;
      } else {
        paint.color = offColor;
      }
      canvas.drawRRect(
        RRect.fromRectAndRadius(segmentsRects[i], Radius.circular(t / 2)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SevenSegmentPainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.color != color ||
        oldDelegate.offColor != offColor ||
        oldDelegate.thickness != thickness;
  }
}
