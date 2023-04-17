import 'dart:math';

import 'package:checkers_game/gamePage/controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class WinnerFireworksComponent extends StatelessWidget {
  const WinnerFireworksComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageController blocController = GamePageController.of(context);
    return ConfettiWidget(
      confettiController: blocController.confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      blastDirection: pi / 2,
      particleDrag: 0.05,
      emissionFrequency: 0.05,
      numberOfParticles: 10,
      gravity: 0.2,
      shouldLoop: false,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ], // manually specify the colors to be used
    );
  }
}
