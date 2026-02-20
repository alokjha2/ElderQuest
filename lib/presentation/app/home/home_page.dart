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
        route: '/tapme',
        color: AppColors.primary,
      ),
      _GameTile(
        title: 'Stop It!',
        subtitle: 'Perfect timing',
        route: '/stop-it',
        color: AppColors.accent,
      ),
      _GameTile(
        title: 'Hold It!',
        subtitle: "Don't spill",
        route: '/hold-it',
        color: AppColors.tileOrange,
      ),
      _GameTile(
        title: 'Balance It!',
        subtitle: 'Stay steady',
        route: '/balance-it',
        color: AppColors.tilePurple,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => context.go('/settings'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: AppSpacing.xs,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.s16,
          mainAxisSpacing: AppSpacing.s16,
          childAspectRatio: 0.8,
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

  const _GameTile({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
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
            color: AppColors.white,
            width: AppSpacing.sm,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: AppSpacing.s18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.tileTitle),
              const SizedBox(height: AppSpacing.sm),
              Text(subtitle, style: AppTextStyles.tileSubtitle),
            ],
          ),
        ),
      ),
    );
  }
}
