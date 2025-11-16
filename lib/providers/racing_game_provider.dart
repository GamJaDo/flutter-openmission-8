import 'package:flutter/material.dart';
import 'package:flutter_openmission_8_racingcar/models/racing_game.dart';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

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

  bool get isGameFinished {
    if (_game == null) {
      return false;
    }
    return _game!.isFinished();
  }

  List<String> get winners {
    if (_game == null) {
      return [];
    }
    return _game!.winners;
  }

  double get progress {
    if (_game == null) {
      return 0.0;
    }
    return _game!.getProgress();
  }

  void startGame(List<String> carNames, int moveCount) {
    _game = RacingGame(carNames: carNames);
    _game!.totalTurns = moveCount;
    notifyListeners();
  }

  void playTurn() {
    if (_game != null && !_game!.isFinished()) {
      _game!.playTurn();

      if (_game!.isFinished()) {
        _game!.determineWinners();
      }

      notifyListeners();
    }
  }

  void resetGame() {
    _game = null;
    notifyListeners();
  }

  String? validateCarName(String name) {
    if (name.isEmpty) {
      return Constants.emptyCarNameError;
    }
    if (name.length > Constants.maxCarNameLength) {
      return Constants.carNameTooLongError;
    }
  }

  String? validateMoveCount(String count) {
    if (count.isEmpty) {
      return Constants.emptyCarNameError;
    }
    if (!RegExp(r'[0-9]+$').hasMatch(count)) {
      return Constants.invalidMoveCountError;
    }

    int? value = int.tryParse(count);
    if (value == null || value < 1) {
      return Constants.moveCountTooSmallError;
    }
    return null;
  }
}