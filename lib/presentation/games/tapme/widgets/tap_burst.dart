import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TapBurst {
  final Offset position;
  final AnimationController controller;

  TapBurst({required this.position, required this.controller});
}

class TapBurstView extends StatelessWidget {
  final TapBurst burst;

  const TapBurstView({super.key, required this.burst});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    const plusOffsetY = -30.0;
    final target = Offset(screen.width * 0.5, screen.height * 0.28);
    final startPlus = Offset(burst.position.dx, burst.position.dy + plusOffsetY);
    final drift = Offset(
      (target.dx - startPlus.dx) * 0.35,
      (target.dy - startPlus.dy) * 0.35 + 24,
    );

    final scale = Tween<double>(begin: 0.7, end: 1.25).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: Curves.easeOutBack,
      ),
    );
    final fade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeOut),
      ),
    );
    final rise = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: Curves.easeOut,
      ),
    );
    final ripple = Tween<double>(begin: 0.4, end: 1.2).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    return Stack(
      children: [
        Positioned(
          left: burst.position.dx - 24,
          top: burst.position.dy - 24,
          child: _TapRipple(ripple: ripple),
        ),
        Positioned(
          left: startPlus.dx - 24,
          top: startPlus.dy - 24,
          child: AnimatedBuilder(
            animation: burst.controller,
            builder: (context, child) {
              return Opacity(
                opacity: fade.value,
                child: Transform.translate(
                  offset: Offset(
                    drift.dx * burst.controller.value,
                    drift.dy * burst.controller.value + rise.value,
                  ),
                  child: Transform.scale(
                    scale: scale.value,
                    child: child,
                  ),
                ),
              );
            },
            child: const _PlusOne(),
          ),
        ),
      ],
    );
  }
}

class _TapRipple extends StatelessWidget {
  final Animation<double> ripple;

  const _TapRipple({required this.ripple});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ripple,
      builder: (context, child) {
        return Opacity(
          opacity: (1 - ripple.value).clamp(0, 1),
          child: Transform.scale(
            scale: ripple.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _PlusOne extends StatelessWidget {
  const _PlusOne();

  @override
  Widget build(BuildContext context) {
    return Text(
      '+1',
      style: AppTextStyles.titleMedium.copyWith(
        color: AppColors.white,
        fontSize: 22,
      ),
    );
  }
}
