import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LevelConfig {
  final String key;
  final String label;
  final String emoji;
  final Color color;

  const LevelConfig({
    required this.key,
    required this.label,
    required this.emoji,
    required this.color,
  });
}

const List<LevelConfig> defaultLevelConfigs = [
  LevelConfig(
    key: 'easy',
    label: 'EASY',
    emoji: '\u{1F642}',
    color: Color(0xFFB7F2B0),
  ),
  LevelConfig(
    key: 'medium',
    label: 'MEDIUM',
    emoji: '\u{1F60E}',
    color: Color(0xFFFFD66B),
  ),
  LevelConfig(
    key: 'hard',
    label: 'HARD',
    emoji: '\u{1F608}',
    color: Color(0xFF3D2F2F),
  ),
];

Future<List<LevelConfig>> loadLevelConfigs() async {
  final raw = await rootBundle.loadString('assets/json/level_config.json');
  final data = jsonDecode(raw) as Map<String, dynamic>;
  final levels = (data['levels'] as List<dynamic>).cast<Map<String, dynamic>>();
  return levels.map((item) {
    return LevelConfig(
      key: item['key'] as String,
      label: item['label'] as String,
      emoji: item['emoji'] as String,
      color: _hexToColor(item['color'] as String),
    );
  }).toList();
}

Color _hexToColor(String value) {
  final hex = value.replaceAll('#', '');
  final buffer = StringBuffer();
  if (hex.length == 6) buffer.write('ff');
  buffer.write(hex);
  return Color(int.parse(buffer.toString(), radix: 16));
}
