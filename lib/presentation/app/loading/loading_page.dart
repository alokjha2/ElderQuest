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
        if (value.value < max) return;
        if (!controller.hasClients) return;
        final maxScroll = controller.position.maxScrollExtent;
        if (controller.offset >= maxScroll - 8) {
          context.go('/home');
        }
      }

      controller.addListener(maybeGoHome);
      return () => controller.removeListener(maybeGoHome);
    }, [controller, value.value]);

    final progress = value.value / max;
    final isComplete = value.value >= max;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: SafeArea(
        child: Padding(
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
                isComplete ? 'Scroll down to open the game hub.' : 'Preparing your games...',
                style: const TextStyle(fontSize: 16, color: Color(0xFF2E4B63)),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    const _HintCard(
                      title: 'Tap Me!',
                      subtitle: 'Fast fingers, fast scores.',
                    ),
                    const _HintCard(
                      title: 'Stop It!',
                      subtitle: 'Time the stop as close as you can.',
                    ),
                    const _HintCard(
                      title: 'Hold It!',
                      subtitle: 'Fill the jar without overflowing.',
                    ),
                    const _HintCard(
                      title: 'Balance It!',
                      subtitle: 'Keep it steady as it wobbles.',
                    ),
                    const SizedBox(height: 160),
                    if (isComplete)
                      Center(
                        child: Text(
                          'Keep scrolling to enter',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0A2C46),
                              ),
                        ),
                      ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  minHeight: 12,
                  value: progress,
                  backgroundColor: const Color(0xFFDCEFFF),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF2E7BFF)),
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
          ),
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
