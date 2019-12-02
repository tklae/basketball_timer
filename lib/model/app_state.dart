import 'dart:async';
import 'dart:collection';

import 'package:basketball_timer/model/player.dart';
import 'package:mobx/mobx.dart';

part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  static final List<String> playerNames = [
    "Tim",
    "Ayoub",
    "Jonny",
    "Javi",
    "Ole",
    "Collis",
    "Lorenz",
    "Martin",
    "Hans",
  ];

  @observable
  ObservableList<Player> _players;

  Stopwatch _gameTime;
  Timer _refreshTimer;

  @observable
  int updateScreenTicker; //Used to force update the screen when the clock is ticking

  _AppState() {
    _initialize();
  }

  _initialize() {
    _players = _generatePlayers(playerNames);
    _gameTime = Stopwatch();
    updateScreenTicker = 0;
  }

  @computed
  UnmodifiableListView<Player> get playersOnCourt =>
      UnmodifiableListView(_players.where((player) => player.isOnCourt));

  @computed
  UnmodifiableListView<Player> get playersOffCourt =>
      UnmodifiableListView(_players.where((player) => !player.isOnCourt));

  @computed
  Stopwatch get gameTime => _gameTime;

  @action
  void reset() {
    _initialize();
  }

  @action
  void startClock() {
    _gameTime.start();
    _updatePlayersClockState();
    _refreshTimer = new Timer.periodic(
        Duration(seconds: 1), (Timer t) => updateScreenTicker++);
  }

  @action
  void stopClock() {
    _gameTime.stop();
    _updatePlayersClockState();
    _refreshTimer.cancel();
    updateScreenTicker = 0;
  }

  void _updatePlayersClockState() {
    _players.forEach((player) => player.gameClockRunning = _gameTime.isRunning);
  }

  ObservableList<Player> _generatePlayers(List<String> names) {
    return ObservableList.of(names.map((name) => new Player(name)).toList());
  }
}
