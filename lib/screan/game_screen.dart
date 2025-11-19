import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_openmission_8_racingcar/providers/racing_game_provider.dart';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startPlay();
  }

  void _startPlay() {
    _timer = Timer.periodic(
      const Duration(milliseconds: Constants.playIntervalMs), (_) {
        final provider = context.read<RacingGameProvider>();

        if (provider.currentTurn < provider.totalTurns) {
          provider.playTurn();
        } else {
          _timer?.cancel();

          Future.delayed(const Duration(seconds: 2), (){
            provider.finishGameScreen();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '턴: ${provider.currentTurn} / ${provider.totalTurns}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: provider.progress,
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[50],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        Constants.executionResult,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (int i=0; i<provider.carNames.length; i++)
                        _buildCarRow(
                          provider.carNames[i],
                          provider.carDistances[i],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarRow(String carName, int distance) {
    double progress = (distance / Constants.progressBarUnit).clamp(0.0, 1.0);

    return Container(
      height: Constants.carRowHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              carName,style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 30,
                  width: ((distance / Constants.progressBarUnit) * 300).clamp(0, 300),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Positioned(
                  left: (progress * 300) - 10,
                  top: 5,
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              '$distance칸',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
