import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import 'home_tile.dart';

class HomeTileItem {
  final String title;
  final String subtitle;
  final String route;
  final Color color;
  final Color textColor;

  const HomeTileItem({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
    required this.textColor,
  });
}

class HomeGrid extends StatelessWidget {
  final List<HomeTileItem> items;

  const HomeGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.xl,
      mainAxisSpacing: AppSpacing.xl,
      childAspectRatio: 0.7,
      children: items
          .map(
            (item) => HomeTile(
              title: item.title,
              subtitle: item.subtitle,
              route: item.route,
              color: item.color,
              textColor: item.textColor,
            ),
          )
          .toList(),
    );
  }
}
