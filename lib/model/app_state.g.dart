// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppState on _AppState, Store {
  Computed<UnmodifiableListView<Player>> _$playersOnCourtComputed;

  @override
  UnmodifiableListView<Player> get playersOnCourt =>
      (_$playersOnCourtComputed ??= Computed<UnmodifiableListView<Player>>(
              () => super.playersOnCourt))
          .value;
  Computed<UnmodifiableListView<Player>> _$playersOffCourtComputed;

  @override
  UnmodifiableListView<Player> get playersOffCourt =>
      (_$playersOffCourtComputed ??= Computed<UnmodifiableListView<Player>>(
              () => super.playersOffCourt))
          .value;
  Computed<Stopwatch> _$gameTimeComputed;

  @override
  Stopwatch get gameTime =>
      (_$gameTimeComputed ??= Computed<Stopwatch>(() => super.gameTime)).value;

  final _$_playersAtom = Atom(name: '_AppState._players');

  @override
  ObservableList<Player> get _players {
    _$_playersAtom.context.enforceReadPolicy(_$_playersAtom);
    _$_playersAtom.reportObserved();
    return super._players;
  }

  @override
  set _players(ObservableList<Player> value) {
    _$_playersAtom.context.conditionallyRunInAction(() {
      super._players = value;
      _$_playersAtom.reportChanged();
    }, _$_playersAtom, name: '${_$_playersAtom.name}_set');
  }

  final _$updateScreenTickerAtom = Atom(name: '_AppState.updateScreenTicker');

  @override
  int get updateScreenTicker {
    _$updateScreenTickerAtom.context
        .enforceReadPolicy(_$updateScreenTickerAtom);
    _$updateScreenTickerAtom.reportObserved();
    return super.updateScreenTicker;
  }

  @override
  set updateScreenTicker(int value) {
    _$updateScreenTickerAtom.context.conditionallyRunInAction(() {
      super.updateScreenTicker = value;
      _$updateScreenTickerAtom.reportChanged();
    }, _$updateScreenTickerAtom, name: '${_$updateScreenTickerAtom.name}_set');
  }

  final _$_AppStateActionController = ActionController(name: '_AppState');

  @override
  void reset() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startClock() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.startClock();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopClock() {
    final _$actionInfo = _$_AppStateActionController.startAction();
    try {
      return super.stopClock();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }
}
