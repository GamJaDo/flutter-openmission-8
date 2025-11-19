import 'package:flutter/material.dart';
import 'package:flutter_openmission_8_racingcar/models/racing_game.dart';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

class RacingGameProvider extends ChangeNotifier {
  RacingGame? _game;
  bool _isReadyToInput = false;
  bool _showGameScreen = false;

  RacingGame? get game {
    return _game;
  }

  bool get isReadyToInput {
    return _isReadyToInput;
  }

  bool get showGameScreen {
    return _showGameScreen;
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

  List<String> get carNames {
    if (_game == null) {
      return [];
    }

    final cars = _game!.cars;
    List<String> names = [];
    for (var car in cars) {
      names.add(car.name);
    }
    return names;
  }

  List<int> get carDistances {
    if (_game == null) {
      return [];
    }

    final cars = _game!.cars;
    List<int> distances = [];
    for (var car in cars) {
      distances.add(car.distance);
    }
    return distances;
  }

  void startInputScreen() {
    _isReadyToInput = true;
    notifyListeners();
  }

  void startGame(List<String> carNames, int moveCount) {
    if (carNames.isEmpty || moveCount <= 0) {
      return;
    }
    _game = RacingGame(carNames: carNames);
    _game!.totalTurns = moveCount;
    _isReadyToInput = false;
    _showGameScreen = true;
    notifyListeners();
  }

  void playTurn() {
    if (_game == null) {
      return;
    }

    if (_game!.isFinished()) {
      return ;
    }

    _game!.playTurn();
    if (_game!.isFinished()) {
      _game!.determineWinners();
    }

    notifyListeners();
  }

  void finishGameScreen() {
    _showGameScreen = false;
    notifyListeners();
  }

  void resetGame() {
    _game = null;
    _isReadyToInput = false;
    _showGameScreen = false;
    notifyListeners();
  }

  String? validateCarName(String name) {
    if (name.isEmpty) {
      return Constants.emptyCarNameError;
    }
    if (name.length > Constants.maxCarNameLength) {
      return Constants.carNameTooLongError;
    }
    return null;
  }

  String? validateMoveCount(String count) {
    if (count.isEmpty) {
      return Constants.emptyMoveCountError;
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