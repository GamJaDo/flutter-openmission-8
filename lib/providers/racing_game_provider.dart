import 'package:flutter/material.dart';
import 'package:flutter_openmission_8_racingcar/models/racing_game.dart';

class RacingGameProvider extends ChangeNotifier {
  RacingGame? _game;

  RacingGame? get game {
    return _game;
  }

  bool get isGameStarted {
    return _game != null;
  }

  int get currentTurn {
    if (_game == null) {
      return 0;
    }
    return _game!.currentTurn;
  }

  int get totalTurns {
    if (_game == null) {
      return 0;
    }
    return _game!.totalTurns;
  }

  void startGame(List<String> carNames, int moveCount) {
    _game = RacingGame(carNames: carNames);
    _game!.totalTurns = moveCount;
    notifyListeners();
  }

  void playTurn() {
    if (_game != null && _game!.currentTurn < _game!.totalTurns) {
      _game!.playTurn();
      notifyListeners();
    }
  }
}