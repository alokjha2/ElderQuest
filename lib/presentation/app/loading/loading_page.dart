import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class LoadingPage extends HookWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const max = 100;
    final value = useState(0);
    final controller = useScrollController();
    final isComplete = value.value >= max;
    final height = MediaQuery.of(context).size.height;

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
      void maybeGoHome() {
        if (!isComplete) return;
        if (!controller.hasClients) return;
        final maxScroll = controller.position.maxScrollExtent;
        if (controller.offset >= maxScroll - 8) {
          context.go('/home');
        }
      }

      controller.addListener(maybeGoHome);
      return () => controller.removeListener(maybeGoHome);
    }, [controller, isComplete]);

    final progress = value.value / max;
    final blink = useAnimationController(
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    final blinkOpacity = Tween<double>(begin: 0.3, end: 1.0).animate(blink);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.2),
                  Text(
                    'ElderQuest',
                    style: GoogleFonts.fuzzyBubbles(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  
                  SizedBox(height: height * 0.45),
                  if (!isComplete)
                    Column(
                      children: [
                        Text(
                    isComplete ? '' : 'Preparing your games...',
                    style: AppTextStyles.bodySecondary,
                  ),
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
                                    minHeight: AppSpacing.xl,
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
                      ],
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
                  const SizedBox(height: AppSpacing.s48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
