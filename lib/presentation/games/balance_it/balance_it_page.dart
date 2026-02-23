import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/component/game_page_card.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class BalanceItPage extends HookWidget {
  const BalanceItPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 2200),
    );
    final animator = useMemoized(
      () => BalanceItAnimator(controller: controller),
      [controller],
    );
    final animatedBall = useAnimation(animator.ballAnimation);
    final isGameEnded = useState(false);
    final frozenBallPosition = useState(0.0);
    final targetValue = useMemoized(_randomTargetValue);

    useEffect(() {
      AudioService.instance
          .setBackgroundVolume(AudioService.gameplayBackgroundVolume);
      controller.repeat(reverse: true);
      return () {
        controller.stop();
      };
    }, [controller]);

    final ballPosition =
        isGameEnded.value ? frozenBallPosition.value : animatedBall;
    final tiltRadians = animator.tiltFor(ballPosition);

    return GamePageCard(
      title: 'BALANCE IT',
      // backgroundColor: const Color(0xFFF5F5F5),
      onBack: () => context.pop(),
      onTapDown: (_) {
        if (isGameEnded.value) return;
        frozenBallPosition.value = animatedBall;
        isGameEnded.value = true;
        controller.stop();
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
        child: Column(
          children: [
            Text(
              'TARGET: $targetValue',
              style: AppTextStyles.scoreText,
            ),
            const SizedBox(height: AppSpacing.s16),
            Expanded(
              child: Center(
                child: BalanceItBoard(
                  ballPosition: ballPosition,
                  tiltRadians: tiltRadians,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            Text(
              isGameEnded.value ? 'Game ended' : 'Press anywhere to stop',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: AppSpacing.s20),
          ],
        ),
      ),
    );
  }
}

class BalanceItAnimator {
  static const double maxRange = 30.0;
  final AnimationController controller;
  late final Animation<double> ballAnimation;

  BalanceItAnimator({required this.controller}) {
    ballAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 20.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 20.0, end: -24.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -24.0, end: 12.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(controller);
  }

  double tiltFor(double position) {
    final normalized = (position / maxRange).clamp(-1.0, 1.0);
    return normalized * 0.12;
  }
}

class BalanceItBoard extends StatelessWidget {
  final double ballPosition;
  final double tiltRadians;

  const BalanceItBoard({
    super.key,
    required this.ballPosition,
    required this.tiltRadians,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final plankWidth = maxWidth * 0.8;
        final plankHeight = max(18.0, plankWidth * 0.06);
        final baseWidth = plankWidth * 0.22;
        final baseHeight = baseWidth * 0.75;
        final ballRadius = plankHeight * 0.65;

        final normalized =
            (ballPosition / BalanceItAnimator.maxRange).clamp(-1.0, 1.0);
        final maxTravel = plankWidth * 0.4;
        final ballX = normalized * maxTravel;

        return SizedBox(
          width: plankWidth,
          height: baseHeight + plankHeight + ballRadius * 2.2,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SeesawBase(
                width: baseWidth,
                height: baseHeight,
              ),
              Positioned(
                bottom: baseHeight - plankHeight * 0.35,
                child: Transform.rotate(
                  angle: tiltRadians,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: plankWidth,
                    height: plankHeight + ballRadius * 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SeesawPlank(
                          width: plankWidth,
                          height: plankHeight,
                        ),
                        Positioned(
                          top: 2,
                          child: CustomPaint(
                            size: Size(plankWidth, plankHeight),
                            painter: ScalePainter(),
                          ),
                        ),
                        Positioned(
                          bottom: plankHeight * 0.25,
                          left: (plankWidth / 2) + ballX - ballRadius,
                          child: BallWidget(radius: ballRadius),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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

class ScalePainter extends CustomPainter {
  static const int maxValue = 30;

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
      final x = centerX + (i / maxValue) * size.width * 0.38;
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

class BallWidget extends StatelessWidget {
  final double radius;

  const BallWidget({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: radius * 0.2,
            child: Container(
              width: radius * 1.4,
              height: radius * 0.5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(radius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                center: Alignment(-0.4, -0.4),
                radius: 0.9,
                colors: [
                  Color(0xFFFFE5B4),
                  Color(0xFFDE8F43),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int _randomTargetValue() {
  final values = <int>[];
  for (int i = -30; i <= 30; i += 5) {
    if (i != 0) {
      values.add(i);
    }
  }
  return values[Random().nextInt(values.length)];
}
