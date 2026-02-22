import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class ScoreText extends StatelessWidget {
  final int score;

  const ScoreText({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Text('Score: $score', style: AppTextStyles.scoreText);
  }
}
