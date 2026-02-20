import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EndScorePage extends HookWidget {
  final String modeTitle;
  final int score;
  final String bestLabel;
  final VoidCallback? onShare;
  final VoidCallback? onExit;
  final VoidCallback? onAgain;

  const EndScorePage({
    super.key,
    required this.modeTitle,
    required this.score,
    this.bestLabel = 'DAILY BEST',
    this.onShare,
    this.onExit,
    this.onAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF44336),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Piano Tiles (Don\'t tap the white tile)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '1795',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.music_note, color: Colors.white, size: 18),
                ],
              ),
              const SizedBox(height: 36),
              Text(
                '5 x 5',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                modeTitle,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 32),
              Text(
                '$score',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 88,
                    ),
              ),
              const SizedBox(height: 32),
              Text(
                bestLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionText(
                    label: 'Share',
                    onTap: onShare,
                  ),
                  _ActionText(
                    label: 'Exit',
                    onTap: onExit ?? () => Navigator.of(context).maybePop(),
                  ),
                  _ActionText(
                    label: 'Again',
                    onTap: onAgain,
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionText extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _ActionText({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
