import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/audio/audio_permissions.dart';
import '../../../../core/theme/app_spacing.dart';

import 'footer_text.dart';
import 'header_bar.dart';
import 'section_title.dart';
import 'slider_row.dart';
import 'toggle_row.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderBar(),
        const Expanded(
          child: SettingsContent(),
        ),
      ],
    );
  }
}

class SettingsContent extends HookWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final volume = useState(0.75);
    final musicOn = useState(true);
    final darkMode = useState(false);
    final vibrationOn = useState(true);

    useEffect(() {
      Future<void>(() async {
        musicOn.value = await AudioPermissions.instance.checkPermission();
      });
      return null;
    }, const []);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s18,
        AppSpacing.s20,
        AppSpacing.s24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VolumeSection(
            value: volume.value,
            onChanged: (v) => volume.value = v,
          ),
          const SizedBox(height: AppSpacing.s18),
          MusicToggle(
            value: musicOn.value,
            onChanged: (v) async {
              await AudioPermissions.instance.setPermission(v);
              musicOn.value = v;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          ThemeToggle(
            value: darkMode.value,
            onChanged: (v) => darkMode.value = v,
          ),
          const SizedBox(height: AppSpacing.xl),
          VibrationToggle(
            value: vibrationOn.value,
            onChanged: (v) => vibrationOn.value = v,
          ),
          const SizedBox(height: AppSpacing.xl),
          const SizedBox(height: AppSpacing.s18),
          const FooterText(),
        ],
      ),
    );
  }
}

class VolumeSection extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const VolumeSection({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Volume'),
        SliderRow(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class MusicToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const MusicToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleRow(
      label: 'Music',
      value: value,
      onChanged: onChanged,
    );
  }
}

class ThemeToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ThemeToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleRow(
      label: 'Dark Mode',
      value: value,
      onChanged: onChanged,
    );
  }
}

class VibrationToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const VibrationToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleRow(
      label: 'Vibration',
      value: value,
      onChanged: onChanged,
    );
  }
}
