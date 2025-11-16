import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_openmission_8_racingcar/providers/racing_game_provider.dart';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final List<TextEditingController> carNameControllers = 
    List.generate(Constants.numberOfCars, (_) => TextEditingController());
  final TextEditingController moveCountController = TextEditingController();

  final List<String?> carNameErrors = List.filled(Constants.numberOfCars, null);
  String? moveCountError;

  @override
  void dispose() {
    for (var controller in carNameControllers) {
      controller.dispose();
    }
    moveCountController.dispose();
    super.dispose();
  }

  void _startRacing() {
    final provider = context.read<RacingGameProvider>();

    for (int i=0; i<Constants.numberOfCars; i++) {
      carNameErrors[i] = null;
    }
    moveCountError = null;

    bool hasError = false;
    for (int i=0; i<Constants.numberOfCars; i++) {
      carNameErrors[i] = provider.validateCarName(carNameControllers[i].text);
      if (carNameErrors[i] != null) {
        hasError = true;
      }
    }

    moveCountError = provider.validateMoveCount(moveCountController.text);
    if (moveCountError != null) {
      hasError = true;
    }

    if (hasError) {
      setState(() {});
    }
    return;

    List<String> carNames = [];
    for (var controller in carNameControllers) {
      carNames.add(controller.text);
    }

    String moveCountText = moveCountController.text;
    int moveCount = int.parse(moveCountText);

    provider.startGame(carNames, moveCount);
    provider.playTurn();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자동차 이름 입력'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Column(
          children: [
            for (int i=0; i<Constants.numberOfCars; i++) 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('자동차 ${i+1}'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: carNameControllers[i],
                    decoration: InputDecoration(
                      hintText: Constants.carNameHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: carNameErrors[i],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('이동 횟수'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: moveCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: Constants.moveCountHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: moveCountError,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 32,),
            SizedBox(
              width: double.infinity,
              height: Constants.buttonHeight,
              child: ElevatedButton(
                onPressed: _startRacing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  Constants.racingButton,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

