import 'package:flutter/material.dart';

void main() {
  runApp(const ElderQuestApp());
}

class ElderQuestApp extends StatelessWidget {
  const ElderQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElderQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ElderQuest')),
      body: const Center(
        child: Text('Project reset complete. Build from here.'),
      ),
    );
  }
}
