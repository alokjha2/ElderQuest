abstract class HoldItEvent {
  const HoldItEvent();
}

class StartHoldEvent extends HoldItEvent {
  const StartHoldEvent();
}

class ReleaseHoldEvent extends HoldItEvent {
  const ReleaseHoldEvent();
}

class TimerTickEvent extends HoldItEvent {
  final int deltaMs;

  const TimerTickEvent(this.deltaMs);
}

class EndGameEvent extends HoldItEvent {
  const EndGameEvent();
}

class ResetHoldEvent extends HoldItEvent {
  const ResetHoldEvent();
}
