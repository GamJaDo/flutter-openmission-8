import 'package:flutter/material.dart';
import 'package:flutter_openmission_8_racingcar/providers/racing_game_provider.dart';
import 'package:flutter_openmission_8_racingcar/screan/home_screen.dart';
import 'package:flutter_openmission_8_racingcar/screan/input_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const RacingCarApp());
}

class RacingCarApp extends StatelessWidget {
  const RacingCarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RacingGameProvider()),
      ],
      child: MaterialApp(
        title: 'Racing Car',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const RacingCarHome(),
      ),
    );
  }
}

class RacingCarHome extends StatelessWidget {
  const RacingCarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RacingGameProvider>(
      builder: (context, provider, _) {
        if (!provider.isGameStarted) {
          return const HomeScreen();
        }
        return const InputScreen();
      },
    );
  }
}

