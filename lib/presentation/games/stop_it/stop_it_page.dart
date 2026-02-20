import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StopItPage extends HookWidget {
  const StopItPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Stop It!'),
      ),
    );
  }
}
