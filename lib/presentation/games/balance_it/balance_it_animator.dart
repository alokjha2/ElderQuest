import 'package:flutter/material.dart';

class BalanceItAnimator {
  static const double maxRange = 50.0;
  final AnimationController controller;
  late final Animation<double> ballAnimation;

  BalanceItAnimator({required this.controller}) {
    ballAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 50.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 50.0, end: -50.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -50.0, end: 20.0)
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
