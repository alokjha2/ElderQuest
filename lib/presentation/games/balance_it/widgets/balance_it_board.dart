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
        final labelHeight = plankHeight * 0.8;
        final scaleHeight = labelHeight + plankHeight * 0.4;

        final normalized =
            (ballPosition / BalanceItAnimator.maxRange).clamp(-1.0, 1.0);
        final maxTravel = (plankWidth / 2) - (ballRadius * 0.95);
        final ballX = normalized * maxTravel;

        return SizedBox(
          width: plankWidth,
          height: baseHeight + labelHeight + plankHeight + ballRadius * 2.2,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SeesawBase(
                width: baseWidth,
                height: baseHeight,
              ),
              Positioned(
                bottom: baseHeight - (plankHeight * 0.8),
                child: Transform.rotate(
                  angle: tiltRadians,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: plankWidth,
                    height: labelHeight + plankHeight + ballRadius * 2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          child: SizedBox(
                            width: plankWidth,
                            height: scaleHeight,
                            child: RepaintBoundary(
                              child: CustomPaint(
                                size: Size(plankWidth, scaleHeight),
                                painter: ScalePainter(
                                  plankHeight: plankHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: SizedBox(
                            width: plankWidth,
                            height: scaleHeight,
                            child: RepaintBoundary(
                              child: ScaleLabels(plankHeight: plankHeight),
                            ),
                          ),
                        ),
                        Positioned(
                          top: labelHeight,
                          child: RepaintBoundary(
                            child: SeesawPlank(
                              width: plankWidth,
                              height: plankHeight,
                            ),
                          ),
                        ),
                        Positioned(
                          top: labelHeight - (ballRadius * 0.15),
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
