import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class GameIntroPage extends HookWidget {
  final String title;
  final String description;
  final String playRoute;
  final Color accent;
  final Color topBar;

  const GameIntroPage({
    super.key,
    required this.title,
    required this.description,
    required this.playRoute,
    required this.accent,
    required this.topBar,
  });

  factory GameIntroPage.forGame(String game) {
    switch (game) {
      case 'tapme':
        return const GameIntroPage(
          title: 'TAP ME!',
          description: 'Tap as fast as you can to score higher.',
          playRoute: '/tapme',
          accent: AppColors.primary,
          topBar: Color(0xFF3B2E54),
        );
      case 'stop-it':
        return const GameIntroPage(
          title: 'STOP IT!',
          description:
              'Press start and stop as close as possible to 10.00 seconds.',
          playRoute: '/stop-it',
          accent: AppColors.accent,
          topBar: Color(0xFF3B2E54),
        );
      case 'hold-it':
        return const GameIntroPage(
          title: 'HOLD IT!',
          description:
              'Hold until the jar fills, but don’t overflow.',
          playRoute: '/hold-it',
          accent: AppColors.tileOrange,
          topBar: Color(0xFF3B2E54),
        );
      case 'balance-it':
        return const GameIntroPage(
          title: 'BALANCE IT!',
          description:
              'Keep it steady as long as you can.',
          playRoute: '/balance-it',
          accent: AppColors.tilePurple,
          topBar: Color(0xFF3B2E54),
        );
      default:
        return const GameIntroPage(
          title: 'GAME',
          description: 'Get ready to play.',
          playRoute: '/home',
          accent: AppColors.primary,
          topBar: Color(0xFF3B2E54),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7E5D7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s16,
              AppSpacing.s24,
              AppSpacing.s16,
              AppSpacing.s16,
            ),
            decoration: BoxDecoration(
              color: topBar,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.tileTitle.copyWith(
                    color: AppColors.white,
                    fontSize: 22,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description,
                  style: AppTextStyles.bodySecondary.copyWith(
                    color: AppColors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 32,
                backgroundColor: accent,
                child: const Icon(Icons.sentiment_satisfied_alt,
                    color: AppColors.white, size: 30),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s24),
          Text(
            'MEDIUM',
            style: AppTextStyles.titleMedium.copyWith(
              color: accent,
              fontSize: 24,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.settingsToggleOffBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24,
              0,
              AppSpacing.s24,
              AppSpacing.s32,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go(playRoute),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('PLAY',
                        style: AppTextStyles.buttonLabel),
                  ),
                ),
                const SizedBox(width: AppSpacing.s16),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.settingsThumb,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.help_outline,
                      color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
