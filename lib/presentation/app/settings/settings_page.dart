import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final volume = useState(0.75);
    final musicOn = useState(true);
    final darkMode = useState(false);
    final vibrationOn = useState(true);

    return Scaffold(
      backgroundColor: AppColors.settingsBg,
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s20,
                  AppSpacing.s18,
                  AppSpacing.s20,
                  AppSpacing.s24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle(title: 'Volume'),
                    _SliderRow(
                      value: volume.value,
                      onChanged: (v) => volume.value = v,
                    ),
                    const SizedBox(height: AppSpacing.s18),
                    _ToggleRow(
                      label: 'Music',
                      value: musicOn.value,
                      onChanged: (v) => musicOn.value = v,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _ToggleRow(
                      label: 'Dark Mode',
                      value: darkMode.value,
                      onChanged: (v) => darkMode.value = v,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _ToggleRow(
                      label: 'Vibration',
                      value: vibrationOn.value,
                      onChanged: (v) => vibrationOn.value = v,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const SizedBox(height: AppSpacing.s18),
                    const _FooterText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.settingsBorder, width: 2),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.settingsTitle,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('SETTINGS', style: AppTextStyles.settingsTitle),
            ),
          ),
          const SizedBox(width: AppSpacing.s40),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.settingsSection);
  }
}

class _SliderRow extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _SliderRow({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: AppSpacing.md,
        activeTrackColor: AppColors.settingsTrackActive,
        inactiveTrackColor: AppColors.settingsTrackInactive,
        thumbColor: AppColors.settingsThumb,
        overlayColor: AppColors.settingsThumb.withOpacity(0.2),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
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
          onTap: () => onChanged(!value),
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

// Removed resolution, FPS, and language sections per request.

class _FooterText extends StatelessWidget {
  const _FooterText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: AppTextStyles.settingsFooter,
          children: [
            TextSpan(text: 'Our '),
            TextSpan(text: 'Terms and Privacy Policy.', style: AppTextStyles.settingsFooterLink),
          ],
        ),
      ),
    );
  }
}
