class Score {
  final int value;

  const Score(this.value);

  Score increment() => Score(value + 1);

  Score reset() => const Score(0);
}