import 'package:elder_quest/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_spacing.dart';
import 'header.dart';

class GamePageCard extends HookWidget {
  final String title;
  final VoidCallback onBack;
  final Widget body;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCallback? onTap;

  const GamePageCard({
    super.key,
    required this.title,
    required this.onBack,
    required this.body,
    this.padding = const EdgeInsets.fromLTRB(AppSpacing.s24, AppSpacing.s32,AppSpacing.md, AppSpacing.md,),
    this.backgroundColor = AppColors.hintBlue,
    this.onTapDown,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: onTapDown,
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.s20, AppSpacing.s44,AppSpacing.md, AppSpacing.md,),
              child: Header(title: title, onBack: onBack),
            ),
            const SizedBox(height: AppSpacing.s24),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
