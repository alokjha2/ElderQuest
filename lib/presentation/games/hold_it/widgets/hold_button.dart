import 'package:flutter/material.dart';

class HoldButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onReleased;
  final bool isHolding;

  const HoldButton({
    super.key,
    required this.onPressed,
    required this.onReleased,
    required this.isHolding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      onTapUp: (_) => onReleased(),
      onTapCancel: onReleased,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 20),
        decoration: BoxDecoration(
          color: isHolding ? const Color(0xFFE57373) : const Color(0xFF2E7BFF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          isHolding ? 'HOLDING...' : 'HOLD',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
