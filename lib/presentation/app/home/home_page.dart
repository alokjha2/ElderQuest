import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _GameTile(
        title: 'Tap Me!',
        subtitle: 'Fast fingers',
        route: '/game-intro/tapme',
        color: AppColors.primary,
        textColor: AppColors.white,
      ),
      _GameTile(
        title: 'Stop It!',
        subtitle: 'Perfect timing',
        route: '/game-intro/stop-it',
        color: AppColors.accent,
        textColor: AppColors.white,
      ),
      _GameTile(
        title: 'Hold It!',
        subtitle: "Don't spill",
        route: '/game-intro/hold-it',
        color: AppColors.tileOrange,
        textColor: AppColors.white,
      ),
      _GameTile(
        title: 'Balance It!',
        subtitle: 'Stay steady',
        route: '/game-intro/balance-it',
        color: AppColors.tilePurple,
        textColor: AppColors.white,
      ),
    ];

    return Scaffold(
        backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
      backgroundColor: AppColors.lightBlueFill,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => context.go('/settings'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: AppSpacing.xs,
            color: AppColors.hintBlue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.xl,
          mainAxisSpacing: AppSpacing.xl,
          childAspectRatio: 0.7,
          children: items,
        ),
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  final Color color;
  final Color textColor;

  const _GameTile({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(AppSpacing.s20),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSpacing.s28),
          border: Border.all(
            color: AppColors.white.withOpacity(0.35),
            width: AppSpacing.xs,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.tileTitle.copyWith(color: textColor),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Container(
                      height: AppSpacing.xs,
                      decoration: BoxDecoration(
                      color: textColor,
                        borderRadius: BorderRadius.circular(AppSpacing.s18)),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: AppSpacing.sm),
              // Text(subtitle, style: AppTextStyles.tileSubtitle),
            ],
          ),
        ),
      ),
    );
  }
}
