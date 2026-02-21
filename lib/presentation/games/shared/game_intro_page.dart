import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class GameIntroPage extends HookWidget {
  final String title;
  final String description;
  final String playRoute;
  final Color accent;
  final Color topBar;

  const GameIntroPage({
    super.key,
    required this.title,
    required this.description,
    required this.playRoute,
    required this.accent,
    required this.topBar,
  });

  factory GameIntroPage.forGame(String game) {
    switch (game) {
      case 'tapme':
        return const GameIntroPage(
          title: 'TAP ME!',
          description: 'Tap as fast as you can to score higher.',
          playRoute: '/tapme',
          accent: AppColors.primary,
          topBar: Color(0xFF3B2E54),
        );
      case 'stop-it':
        return const GameIntroPage(
          title: 'STOP IT!',
          description:
              'Press start and stop as close as possible to 10.00 seconds.',
          playRoute: '/stop-it',
          accent: AppColors.accent,
          topBar: Color(0xFF3B2E54),
        );
      case 'hold-it':
        return const GameIntroPage(
          title: 'HOLD IT!',
          description:
              'Hold until the jar fills, but don’t overflow.',
          playRoute: '/hold-it',
          accent: AppColors.tileOrange,
          topBar: Color(0xFF3B2E54),
        );
      case 'balance-it':
        return const GameIntroPage(
          title: 'BALANCE IT!',
          description:
              'Keep it steady as long as you can.',
          playRoute: '/balance-it',
          accent: AppColors.tilePurple,
          topBar: Color(0xFF3B2E54),
        );
      default:
        return const GameIntroPage(
          title: 'GAME',
          description: 'Get ready to play.',
          playRoute: '/home',
          accent: AppColors.primary,
          topBar: Color(0xFF3B2E54),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final difficultyIndex = useState(1);
    final levelsFuture = useMemoized(_loadLevels);
    final levelsSnapshot = useFuture(levelsFuture);

    final levels = levelsSnapshot.data ??
        const [
          _LevelConfig(
            key: 'easy',
            label: 'EASY',
            emoji: '🙂',
            color: Color(0xFFB7F2B0),
          ),
          _LevelConfig(
            key: 'medium',
            label: 'MEDIUM',
            emoji: '😎',
            color: Color(0xFFFFD66B),
          ),
          _LevelConfig(
            key: 'hard',
            label: 'HARD',
            emoji: '😈',
            color: Color(0xFF3D2F2F),
          ),
        ];
    return Scaffold(
      backgroundColor: const Color(0xFFF7E5D7),
      body: Column(
        children: [
          Container(
            height: 300,
            
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s18,
              AppSpacing.s56,
              AppSpacing.s16,
              AppSpacing.s16,
            ),
            decoration: BoxDecoration(
              color: topBar,
              // borderRadius: const BorderRadius.vertical(
              //   // bottom: Radius.circular(24),
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20), ), 
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                      ),
                    ),
                const SizedBox(width: AppSpacing.xl),
                    
                     Text(
                  title,
                  style: AppTextStyles.tileTitle.copyWith(
                    color: AppColors.white,
                    fontSize: 30,
                    letterSpacing: 1.2,
                  ),
                ),
                  ],
                ),
               
                const SizedBox(height: AppSpacing.s18),
                Text(
                  description,
                  style: AppTextStyles.bodySecondary.copyWith(
                    color: AppColors.white70,
                    fontSize: 18
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
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
                backgroundColor: levels[difficultyIndex.value].color,
                child: Text(
                  levels[difficultyIndex.value].emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s24),
          Text(
            levels[difficultyIndex.value].label,
            style: AppTextStyles.titleMedium.copyWith(
              color: levels[difficultyIndex.value].color,
              fontSize: 24,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
            child: _DifficultySlider(
              index: difficultyIndex.value,
              levels: levels,
              onChanged: (i) => difficultyIndex.value = i,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24,
              0,
              AppSpacing.s24,
              AppSpacing.s32,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go(playRoute),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('PLAY',
                        style: AppTextStyles.buttonLabel),
                  ),
                ),
                // const SizedBox(width: AppSpacing.s16),
                // Container(
                //   width: 52,
                //   height: 52,
                //   decoration: BoxDecoration(
                //     color: AppColors.settingsThumb,
                //     borderRadius: BorderRadius.circular(14),
                //   ),
                //   child: const Icon(Icons.help_outline,
                //       color: AppColors.white),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelConfig {
  final String key;
  final String label;
  final String emoji;
  final Color color;

  const _LevelConfig({
    required this.key,
    required this.label,
    required this.emoji,
    required this.color,
  });
}

Future<List<_LevelConfig>> _loadLevels() async {
  final raw = await rootBundle.loadString('assets/json/level_config.json');
  final data = jsonDecode(raw) as Map<String, dynamic>;
  final levels = (data['levels'] as List<dynamic>).cast<Map<String, dynamic>>();
  return levels.map((item) {
    return _LevelConfig(
      key: item['key'] as String,
      label: item['label'] as String,
      emoji: item['emoji'] as String,
      color: _hexToColor(item['color'] as String),
    );
  }).toList();
}

Color _hexToColor(String value) {
  final hex = value.replaceAll('#', '');
  final buffer = StringBuffer();
  if (hex.length == 6) buffer.write('ff');
  buffer.write(hex);
  return Color(int.parse(buffer.toString(), radix: 16));
}

class _DifficultySlider extends StatelessWidget {
  final int index;
  final List<_LevelConfig> levels;
  final ValueChanged<int> onChanged;

  const _DifficultySlider({
    required this.index,
    required this.levels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final trackColors = levels.map((e) => e.color).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final knobSize = 52.0;
        final trackHeight = 40.0;
        final trackPadding = 4.0;
        final trackRadius = 24.0;
        final available = (constraints.maxWidth - knobSize).clamp(0, double.infinity);
        final x = (available / (levels.length - 1)) * index;
        final progress = index / (levels.length - 1);

        return SizedBox(
          height: 62,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              GestureDetector(
                onTapUp: (details) {
                  final third = constraints.maxWidth / levels.length;
                  final localX = details.localPosition.dx;
                  final i =
                      (localX / third).clamp(0, levels.length - 1).floor();
                  onChanged(i);
                },
                child: Container(
                  height: trackHeight,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(trackRadius),
                  ),
                  child: LayoutBuilder(
                    builder: (context, inner) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.settingsToggleOffBg,
                              borderRadius: BorderRadius.circular(trackRadius),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: trackColors[index],
                                borderRadius: BorderRadius.circular(trackRadius),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                left: x,
                child: Container(
                  width: knobSize,
                  height: knobSize,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: knobSize - 16,
                    height: knobSize - 16,
                    decoration: BoxDecoration(
                      color: trackColors[index],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
