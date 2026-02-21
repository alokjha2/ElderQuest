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
    this.padding = const EdgeInsets.all(AppSpacing.s24),
    this.backgroundColor,
    this.onTapDown,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: onTapDown,
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.s16),
                  child: Header(title: title, onBack: onBack),
                ),
                const SizedBox(height: AppSpacing.s24),
                Expanded(child: body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
