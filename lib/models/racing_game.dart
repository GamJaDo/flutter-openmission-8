import 'package:flutter_openmission_8_racingcar/models/car.dart';

class RacingGame {
  final List<Car> cars;

  RacingGame({required List<String> carNames}):
    cars = carNames.map((name) => Car(name)).toList();

}