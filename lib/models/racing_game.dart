import 'package:flutter_openmission_8_racingcar/models/car.dart';

class RacingGame {
  final List<Car> cars;
  int currentTurn = 0;
  int totalTurns = 0;
  List<String> winners = [];

  RacingGame({required List<String> carNames}):
    cars = carNames.map((name) => Car(name)).toList();

  void playTurn() {
    for (var car in cars) {
      car.move();
    }
    currentTurn += 1;
  }

  int findMaxDistance(List<Car> cars) {
    int maxDistance = 0;

    for (var car in cars) {
      if (car.distance > maxDistance) {
        maxDistance = car.distance;
      }
    }
    return maxDistance;
  }

  List<String> findWinners(List<Car> cars, int maxDistance) {
    List<String> winners = [];

    for (var car in cars) {
      if (car.distance == maxDistance) {
        winners.add(car.name);
      }
    }
    return winners;
  }

  void determineWinners() {
    if (cars.isEmpty) {
      return;
    }

    int maxDistance = findMaxDistance(cars);
    winners = findWinners(cars, maxDistance);
  }

  bool isFinished() {
    return currentTurn >= totalTurns;
  }

  double getProgress() {
    if (totalTurns == 0) {
      return 0.0;
    }
    return (currentTurn / totalTurns).clamp(0.0, 1.0);
  }
}