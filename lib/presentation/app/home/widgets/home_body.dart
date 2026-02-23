import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/audio/audio_service.dart';
import '../../../../core/audio/app_sounds.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'home_grid.dart';

class HomeBody extends HookWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future<void>(() async {
        await AudioService.instance.playBackgroundMusic(
          AppSounds.background,
          volume: 0.1,
        );
      });
      return () {
        AudioService.instance.pauseBackgroundMusic();
      };
    }, const []);

    return const Padding(
      padding: EdgeInsets.all(AppSpacing.xl),
      child: HomeGrid(
        items: [
          HomeTileItem(
            title: 'Hold It!',
            subtitle: "Don't spill",
            route: '/game-intro/hold-it',
            color: AppColors.tilePurple,
            textColor: AppColors.white,
            imagePath: 'assets/images/beaker_hold_it.png',
          ),
          HomeTileItem(
            title: 'Tap Me!',
            subtitle: 'Fast fingers',
            route: '/game-intro/tapme',
            color: AppColors.primary,
            textColor: AppColors.white,
            imagePath: 'assets/images/tap_it_click.png',
          ),
          HomeTileItem(
            title: 'Stop It!',
            subtitle: 'Perfect timing',
            route: '/game-intro/stop-it',
            color: AppColors.black87,
            textColor: AppColors.white,
            imagePath: 'assets/images/stop_it_clock.png',
          ),
          // HomeTileItem(
          //   title: 'Balance It!',
          //   subtitle: 'Stay steady',
          //   route: '/game-intro/balance-it',
          //   color: AppColors.tilePurple,
          //   textColor: AppColors.white,
          // ),
        ],
      ),
    );
  }
}
