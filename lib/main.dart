import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
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
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
