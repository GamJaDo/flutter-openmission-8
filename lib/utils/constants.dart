class Constants {
  static const int maxRandomNumber = 9;
  static const int minRandomNumber = 0;
  static const int moveableValue = 4;
  static const int numberOfCars = 3;
  static const int playIntervalMs = 1000;
  static const int maxCarNameLength = 5;

  static const double defaultPadding = 16.0;
  static const double buttonHeight = 50.0;
  static const double carIconSize = 40;
  static const double carRowHeight = 80;
  static const double progressBarUnit = 15;

  static const String startGameBuuton = '게임 시작';
  static const String racingButton = 'Racing';
  static const String carNameHint = '5자리 이하';
  static const String moveCountHint = '1이상 입력';
  static const String executionResult = '실행 결과';
  static const String raceComplete = '경주 완료';
  static const String winnerSign = '우승자: ';
  static const String retryButton = '다시하기';

  static const String emptyCarNameError = '자동차 이름을 입력해야 합니다.';
  static const String carNameTooLongError = '자동차 이름은 5자 이하여야 합니다.';
  static const String invalidMoveCountError = '이동 횟수는 숫자만 입력해야 합니다.';
  static const String moveCountTooSmallError = '이동 횟수는 1 이상이어야 합니다.';
  static const String emptyMoveCountError = '이동 횟수를 입력해야 합니다.';
}