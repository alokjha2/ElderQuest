import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TapMePage extends HookWidget {
  const TapMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tap Me!'),
      ),
    );
  }
}
