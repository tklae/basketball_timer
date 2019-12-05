import 'dart:async';
import 'dart:collection';

import 'package:basketball_timer/model/player.dart';
import 'package:mobx/mobx.dart';

part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  static final List<String> playerNames = [];

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

  @action
  void addPlayer(String name) {
    if (!_players
        .any((player) => player.name.toLowerCase() == name.toLowerCase())) {
      _players.add(Player(name));
    }
  }

  @action
  void deletePlayer(String name) {
    _players.removeWhere(
        (player) => player.name.toLowerCase() == name.toLowerCase());
  }

  @action
  void switchPlayerState(String name) {
    _players
        .where((player) => player.name.toLowerCase() == name.toLowerCase())
        .forEach((player) => player.isOnCourt = !player.isOnCourt);
    //ObservableList does not track changes made via 'where' or 'forEach',
    //therefore we're working around this by manually calling a method that fires
    //an update event
    _players.length = _players.length;
  }

  void _updatePlayersClockState() {
    _players.forEach((player) => player.gameClockRunning = _gameTime.isRunning);
  }

  ObservableList<Player> _generatePlayers(List<String> names) {
    return ObservableList.of(names.map((name) => new Player(name)).toList());
  }
}
