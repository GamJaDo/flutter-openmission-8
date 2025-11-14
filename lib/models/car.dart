import 'dart:math';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

class Car {
  final String name;
  int distance = 0;

  Car(this.name);

  int generateRandomNumber() {
    return Random().nextInt(Constants.maxRandomNumber+1);
  }

  void move() {
    int randomNumber = generateRandomNumber();
    if (randomNumber >= Constants.moveableValue) {
        distance += 1;
    }
  }

  void reset() {
    distance = 0;
  }
}