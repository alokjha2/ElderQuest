import 'dart:math';

int randomTargetValue() {
  final values = <int>[];
  for (int i = -30; i <= 30; i += 5) {
    if (i != 0) {
      values.add(i);
    }
  }
  return values[Random().nextInt(values.length)];
}
