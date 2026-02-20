import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentation/app/routing/app_router.dart';

void main() {
  runApp(const ElderQuestApp());
}

class ElderQuestApp extends StatelessWidget {
  const ElderQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.router;

    return MaterialApp.router(
      title: 'ElderQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
