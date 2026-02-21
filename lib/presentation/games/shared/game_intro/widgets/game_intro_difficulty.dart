import 'package:elder_quest/core/theme/app_colors.dart';
import 'package:elder_quest/core/theme/app_spacing.dart';
import 'package:elder_quest/core/theme/app_text_styles.dart';
import 'package:elder_quest/presentation/games/shared/game_intro/widgets/difficulty_slider.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_spacing.dart';
// import '../../../../core/theme/app_text_styles.dart';
import '../level_config.dart';
// import 'difficulty_slider.dart';

class GameIntroDifficulty extends StatelessWidget {
  final int index;
  final List<LevelConfig> levels;
  final ValueChanged<int> onChanged;

  const GameIntroDifficulty({
    super.key,
    required this.index,
    required this.levels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final current = levels[index];
    final trackColors = levels.map((e) => e.color).toList();

    return Column(
      children: [
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
              radius: 40,
              backgroundColor: current.color,
              child: Text(
                current.emoji,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s24),
        Text(
          current.label,
          style: AppTextStyles.titleMedium.copyWith(
            color: current.color,
            fontSize: 24,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
          child: DifficultySlider(
            index: index,
            trackColors: trackColors,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
