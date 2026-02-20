import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HoldItPage extends HookWidget {
  const HoldItPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hold It!'),
      ),
    );
  }
}
