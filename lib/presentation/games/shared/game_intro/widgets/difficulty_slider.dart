import 'package:elder_quest/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// import '../../../../core/theme/app_colors.dart';

class DifficultySlider extends StatelessWidget {
  final int index;
  final List<Color> trackColors;
  final ValueChanged<int> onChanged;

  const DifficultySlider({
    super.key,
    required this.index,
    required this.trackColors,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final knobSize = 52.0;
        final trackHeight = 40.0;
        final trackRadius = 24.0;
        final available =
            (constraints.maxWidth - knobSize).clamp(0, double.infinity);
        final x = (available / (trackColors.length - 1)) * index;
        final progress = index / (trackColors.length - 1);

        return SizedBox(
          height: 62,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              GestureDetector(
                onTapUp: (details) {
                  final third = constraints.maxWidth / trackColors.length;
                  final localX = details.localPosition.dx;
                  final i = (localX / third)
                      .clamp(0, trackColors.length - 1)
                      .floor();
                  onChanged(i);
                },
                child: Container(
                  height: trackHeight,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(trackRadius),
                  ),
                  child: Stack(
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
