import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

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
      backgroundColor: const Color(0xFFF4FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.2),
                  const Text(
                    'ElderQuest',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2C46),
                      letterSpacing: 1.1,
                    ),
                  ),
                  // const SizedBox(height: 12),
                  
                  SizedBox(height: height * 0.45),
                  Text(
                    isComplete ? '' : 'Preparing your games...',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E4B63),
                    ),
                  ),
                  if (!isComplete)
                    Center(
                      child: SizedBox(
                        width: 240,
                        // height: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: LinearProgressIndicator(
                                minHeight: 12,
                                value: progress,
                                backgroundColor: const Color(0xFFDCEFFF),
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF2E7BFF),
                                ),
                              ),
                            ),
                            Text(
                              '${value.value}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0A2C46),
                              ),
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6CA9FF),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
