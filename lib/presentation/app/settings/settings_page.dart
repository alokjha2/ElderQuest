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
    final resolution = useState(0.6);
    final maxFps = useState(0.65);
    final musicOn = useState(true);
    final darkMode = useState(false);
    final vibrationOn = useState(true);
    final adsOn = useState(true);

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
                    _ToggleRow(
                      label: 'Targeted Ads',
                      value: adsOn.value,
                      onChanged: (v) => adsOn.value = v,
                    ),
                    const SizedBox(height: AppSpacing.s18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionTitle(title: 'Resolution'),
                              _SliderRow(
                                value: resolution.value,
                                onChanged: (v) => resolution.value = v,
                              ),
                              const SizedBox(height: AppSpacing.s18),
                              const _SectionTitle(title: 'Maximum FPS'),
                              _SliderRow(
                                value: maxFps.value,
                                onChanged: (v) => maxFps.value = v,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xxl),
                        const _FpsCard(value: 54),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s22),
                    const _SectionTitle(title: 'Language'),
                    const SizedBox(height: AppSpacing.md),
                    const _LanguageButton(),
                    const SizedBox(height: AppSpacing.s28),
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
            onPressed: () => Navigator.of(context).maybePop(),
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

class _FpsCard extends StatelessWidget {
  final int value;

  const _FpsCard({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.s60 + AppSpacing.s60,
      height: AppSpacing.s60 + AppSpacing.s40,
      decoration: BoxDecoration(
        color: AppColors.settingsCardBg,
        borderRadius: BorderRadius.circular(AppSpacing.s18),
      ),
      child: Stack(
        children: [
          Positioned(
            top: AppSpacing.xl,
            left: AppSpacing.xl,
            child: Text('$value\nFPS', style: AppTextStyles.settingsFpsText),
          ),
          Center(
            child: Container(
              width: AppSpacing.s56,
              height: AppSpacing.s56,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: AppSpacing.xl,
            left: AppSpacing.s18,
            child: Transform.rotate(
              angle: 0.2,
              child: const Icon(
                Icons.change_history,
                size: AppSpacing.s20,
                color: AppColors.settingsIcon,
              ),
            ),
          ),
          Positioned(
            bottom: AppSpacing.lg,
            right: AppSpacing.s18,
            child: Transform.rotate(
              angle: -0.3,
              child: const Icon(
                Icons.change_history,
                size: AppSpacing.s20,
                color: AppColors.settingsIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.settingsThumb,
        borderRadius: BorderRadius.circular(AppSpacing.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.language, color: AppColors.white, size: AppSpacing.s20),
          SizedBox(width: AppSpacing.md),
          Text('System\nLanguage', style: AppTextStyles.settingsLanguage),
        ],
      ),
    );
  }
}

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
