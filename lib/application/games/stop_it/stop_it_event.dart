abstract class StopItEvent {
  const StopItEvent();
}

class StopItStarted extends StopItEvent {
  const StopItStarted();
}

class StopItTicked extends StopItEvent {
  const StopItTicked();
}

class StopItStopped extends StopItEvent {
  const StopItStopped();
}

class StopItReset extends StopItEvent {
  const StopItReset();
}
