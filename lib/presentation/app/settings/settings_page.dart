import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'widgets/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.settingsBg,
      body: const SafeArea(
        child: SettingsBody(),
      ),
    );
  }
}
