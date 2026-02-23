import 'package:flutter/material.dart';

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
