import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_openmission_8_racingcar/providers/racing_game_provider.dart';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('경주 중'),
        centerTitle: true,
      ),
      body: Consumer<RacingGameProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '턴: ${provider.currentTurn} / ${provider.totalTurns}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          );
        }
      ),
    );
  }
}