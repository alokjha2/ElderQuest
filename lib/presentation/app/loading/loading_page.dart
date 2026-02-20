import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class LoadingPage extends HookWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const max = 100;
    final value = useState(0);
    final isComplete = value.value >= max;
    final height = MediaQuery.of(context).size.height;
    final pageController = usePageController(viewportFraction: 0.92);

    useEffect(() {
      final timer = Timer.periodic(const Duration(milliseconds: 20), (t) {
        value.value = (value.value + 1).clamp(0, max);
        if (value.value >= max) {
          t.cancel();
        }
      });
      return timer.cancel;
    }, []);

    useEffect(() {
      void onPageChanged() {
        if (!isComplete) return;
        final page = pageController.hasClients ? pageController.page ?? 0 : 0;
        if (page >= 0.55) {
          context.go('/home');
        }
      }

      pageController.addListener(onPageChanged);
      return () => pageController.removeListener(onPageChanged);
    }, [pageController, isComplete]);

    final progress = value.value / max;
    final blink = useAnimationController(
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    final blinkOpacity = Tween<double>(begin: 0.3, end: 1.0).animate(blink);

    final bounce = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    final bounceOffset = Tween<double>(begin: 0, end: 10).animate(bounce);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: pageController,
        physics: isComplete
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.16),
                  Text(
                    'ElderQuest',
                    style: AppTextStyles.appTitle.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  isComplete ? '' : 'Preparing your games...',
                  style: AppTextStyles.bodySecondary,
                ),
                SizedBox(height: height * 0.36),
                if (!isComplete)
                  Center(
                    child: SizedBox(
                      width: 240,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.xl),
                            child: LinearProgressIndicator(
                              minHeight: AppSpacing.s24,
                              value: progress,
                              backgroundColor: AppColors.lightBlueFill,
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.primary,
                              ),
                            ),
                          ),
                          Text(
                            '${value.value}%',
                            style: AppTextStyles.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (isComplete)
                  FadeTransition(
                    opacity: blinkOpacity,
                    child: const Center(
                      child: Text(
                        'Scroll page to play',
                        style: AppTextStyles.hintBlink,
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.s24),
                if (isComplete)
                  AnimatedBuilder(
                    animation: bounceOffset,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, bounceOffset.value),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 36,
                          color: AppColors.hintBlue,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s24,
              vertical: AppSpacing.s24,
            ),
            // child: Material(
            //   elevation: 6,
            //   shadowColor: AppColors.primary.withOpacity(0.12),
            //   borderRadius: BorderRadius.circular(AppSpacing.s24),
            //   color: AppColors.surface,
            //   // child: Center(
            //   //   child: Text(
            //   //     'Opening...',
            //   //     style: AppTextStyles.bodySecondary,
            //   //   ),
            //   // ),
            // ),
          ),
        ],
      ),
    );
  }
}
