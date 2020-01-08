import 'package:basketball_timer/utils/string_formatter.dart';

class Player {
  final String _name;
  bool _isOnCourt, _gameClockRunning;
  Stopwatch _playingTime;

  Player(this._name)
      : this._playingTime = Stopwatch(),
        this._isOnCourt = false,
        this._gameClockRunning = false;

  String get name => this._name;

  String get formattedPlayingTime => StringFormatter.durationInMinutesAndSeconds(_playingTime.elapsed);
  int get playingTimeInSeconds => _playingTime.elapsed.inSeconds;

  bool get isOnCourt => this._isOnCourt;

  set isOnCourt(bool trigger) {
    this._isOnCourt = trigger;
    _calculateStopWatchState();
  }

  set gameClockRunning(bool trigger) {
    this._gameClockRunning = trigger;
    _calculateStopWatchState();
  }

  void _calculateStopWatchState() {
    isOnCourt && _gameClockRunning ? _playingTime.start() : _playingTime.stop();
  }

  playingTimeInPercentOf(int totalGameTimeInSeconds) {
    return (totalGameTimeInSeconds > 0
        ? playingTimeInSeconds/totalGameTimeInSeconds*100
        : 0).toStringAsFixed(1);
  }
}
