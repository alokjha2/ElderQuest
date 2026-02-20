import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BalanceItPage extends HookWidget {
  const BalanceItPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Balance It!'),
      ),
    );
  }
}
