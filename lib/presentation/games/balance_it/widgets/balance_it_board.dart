import 'dart:math';

import 'package:flutter/material.dart';

import '../balance_it_animator.dart';
import 'ball_widget.dart';
import 'scale_painter.dart';
import 'seesaw_base.dart';
import 'seesaw_plank.dart';

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
        final plankHeight = max(24.0, plankWidth * 0.08);
        final baseWidth = plankWidth * 0.22;
        final baseHeight = baseWidth * 0.75;
        final ballRadius = plankHeight * 0.5;

        final normalized =
            (ballPosition / BalanceItAnimator.maxRange).clamp(-1.0, 1.0);
        final maxTravel = (plankWidth / 2) - (ballRadius * 0.95);
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
                          // bottom: plankHeight * 0.02,
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
