import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int elapsedHundredths;
  final int targetHundredths;

  const TimerDisplay({
    super.key,
    required this.elapsedHundredths,
    required this.targetHundredths,
  });

  String _format(int hundredths) {
    final seconds = hundredths ~/ 100;
    final fraction = hundredths % 100;
    final secStr = seconds.toString().padLeft(2, '0');
    final fracStr = fraction.toString().padLeft(2, '0');
    return '$secStr.$fracStr';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _format(elapsedHundredths),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0A2C46),
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Target ${_format(targetHundredths)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF2E4B63),
              ),
        ),
      ],
    );
  }
}
