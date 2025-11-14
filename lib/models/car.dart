import 'dart:math';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

class Car {
  final String name;

  Car(this.name);

  int generateRandomNumber() {
    return Random().nextInt(Constants.maxRandomNumber+1);
  }
}