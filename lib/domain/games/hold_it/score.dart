class Score {
  final int value;

  const Score(this.value);

  Score increment([int by = 1]) => Score(value + by);

  Score reset() => const Score(0);
}
