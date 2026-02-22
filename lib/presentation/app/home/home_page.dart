import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import 'widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
      backgroundColor: AppColors.lightBlueFill,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => context.push('/settings'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: AppSpacing.xs,
            color: AppColors.hintBlue,
          ),
        ),
      ),
      body: HomeBody(),
    );
  }
}
