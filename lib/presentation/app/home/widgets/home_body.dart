import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/audio/audio_service.dart';
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
          'assets/sounds/bg2.mp3',
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
            title: 'Tap Me!',
            subtitle: 'Fast fingers',
            route: '/game-intro/tapme',
            color: AppColors.primary,
            textColor: AppColors.white,
          ),
          HomeTileItem(
            title: 'Stop It!',
            subtitle: 'Perfect timing',
            route: '/game-intro/stop-it',
            color: AppColors.accent,
            textColor: AppColors.white,
          ),
          HomeTileItem(
            title: 'Hold It!',
            subtitle: "Don't spill",
            route: '/game-intro/hold-it',
            color: AppColors.tileOrange,
            textColor: AppColors.white,
          ),
          HomeTileItem(
            title: 'Balance It!',
            subtitle: 'Stay steady',
            route: '/game-intro/balance-it',
            color: AppColors.tilePurple,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
