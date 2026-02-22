import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/audio/audio_service.dart';

class BalanceItPage extends HookWidget {
  const BalanceItPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      AudioService.instance
          .setBackgroundVolume(AudioService.gameplayBackgroundVolume);
      return null;
    }, const []);

    return const Scaffold(
      body: Center(
        child: Text('Balance It!'),
      ),
    );
  }
}
