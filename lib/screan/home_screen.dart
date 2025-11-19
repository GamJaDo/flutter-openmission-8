import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_openmission_8_racingcar/providers/racing_game_provider.dart';
import 'package:flutter_openmission_8_racingcar/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Racing Car'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<RacingGameProvider>().startInputScreen();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            backgroundColor: Colors.blue,
          ),
          child : const Text(
            Constants.startGameBuuton,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}