import 'package:flutter_openmission_8_racingcar/models/car.dart';

class RacingGame {
  final List<Car> cars;
  int currentTurn = 0;
  int totalTurns = 0;

  RacingGame({required List<String> carNames}):
    cars = carNames.map((name) => Car(name)).toList();

  void playTurn() {
    for (var car in cars) {
      car.move();
    }
    currentTurn += 1;
  }
}