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
    final pageController = usePageController();
    final isComplete = value.value >= max;

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
        final page = pageController.hasClients ? pageController.page ?? 0 : 0;
        if (page >= 1.0) {
          context.go('/home');
        }
      }

      pageController.addListener(maybeGoHome);
      return () => pageController.removeListener(maybeGoHome);
    }, [pageController, isComplete]);

    final progress = value.value / max;
    final blink = useAnimationController(
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    final blinkOpacity = Tween<double>(begin: 0.3, end: 1.0).animate(blink);

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: pageController,
          physics: isComplete
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0A2C46),
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isComplete
                        ? 'Scroll page to play'
                        : 'Preparing your games...',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E4B63),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Expanded(
                  //   child: ListView(
                  //     children: const [
                  //       _HintCard(
                  //         title: 'Tap Me!',
                  //         subtitle: 'Fast fingers, fast scores.',
                  //       ),
                  //       _HintCard(
                  //         title: 'Stop It!',
                  //         subtitle: 'Time the stop as close as you can.',
                  //       ),
                  //       _HintCard(
                  //         title: 'Hold It!',
                  //         subtitle: 'Fill the jar without overflowing.',
                  //       ),
                  //       _HintCard(
                  //         title: 'Balance It!',
                  //         subtitle: 'Keep it steady as it wobbles.',
                  //       ),
                  //       SizedBox(height: 120),
                  //     ],
                  //   ),
                  // ),

                  
                  if (!isComplete) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        minHeight: 12,
                        value: progress,
                        backgroundColor: const Color(0xFFDCEFFF),
                        valueColor:
                            const AlwaysStoppedAnimation(Color(0xFF2E7BFF)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${value.value}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A2C46),
                        ),
                      ),
                    ),
                  ],
                  if (isComplete)
                    FadeTransition(
                      opacity: blinkOpacity,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Scroll page to play',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA7C7FF),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: const Color(0xFFF4FAFF),
              child: const Text(
                'Opening Game Hub…',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A2C46),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HintCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HintCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0A2C46),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFF4D6A83)),
          ),
        ],
      ),
    );
  }
}
