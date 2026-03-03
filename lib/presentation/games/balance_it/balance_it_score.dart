


int calculateScore(int target, double position) {
  final difference = (position - target).abs();
  final score = (100 - (difference * 3)).round();
  return score.clamp(0, 100);
}
