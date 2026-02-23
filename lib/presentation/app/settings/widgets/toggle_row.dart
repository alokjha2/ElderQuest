import 'package:elder_quest/core/audio/game_audio_player.dart';
import 'package:elder_quest/core/audio/app_sounds.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.settingsSection)),
        GestureDetector(
          onTap: () async {
            final sfx = GameAudioPlayer();
            onChanged(!value);
            await sfx.playSfx(AppSounds.toggle);
          },
          child: Container(
            width: AppSpacing.s58,
            height: AppSpacing.s32,
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: value
                  ? AppColors.settingsToggleOnBg
                  : AppColors.settingsToggleOffBg,
              borderRadius: BorderRadius.circular(AppSpacing.s18),
            ),
            child: Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: AppSpacing.s22,
                height: AppSpacing.s22,
                decoration: BoxDecoration(
                  color: value
                      ? AppColors.settingsThumb
                      : AppColors.settingsThumbDark,
                  shape: BoxShape.circle,
                ),
                child: value
                    ? const Icon(Icons.check,
                        size: AppSpacing.xl, color: AppColors.white)
                    : const Icon(Icons.close,
                        size: AppSpacing.xl, color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
