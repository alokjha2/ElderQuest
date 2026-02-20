import 'package:flutter/material.dart';

class HoldProgressIndicator extends StatelessWidget {
  final double progress;

  const HoldProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: LinearProgressIndicator(
        minHeight: 12,
        value: progress.clamp(0.0, 1.0),
        backgroundColor: const Color(0xFFDCEFFF),
        valueColor: const AlwaysStoppedAnimation(Color(0xFF2E7BFF)),
      ),
    );
  }
}
