import 'package:checkers_game/constants.dart';
import 'package:checkers_game/gamePage/controller.dart';
import 'package:checkers_game/gamePage/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPlayerComponent extends StatelessWidget {
  const CurrentPlayerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageController blocController = GamePageController.of(context);
    return BlocBuilder(
      bloc: blocController,
      builder: (context, state) {
        PLayerModel currentPlayer = blocController.boardModel.winner?? blocController.boardModel.currentPlayer!;
        if (blocController.aiEnemyModel != null && blocController.boardModel.winner == null) return const SizedBox();
        return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: currentPlayer.isWhite ? 'Red ' : 'Black ',
                  style: TextStyle(
                    color: currentPlayer.isWhite ? kPrimaryColor : null,
                    foreground: currentPlayer.isWhite ?null :( Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.white),
                  ),
                ),
                TextSpan(
                  text: blocController.boardModel.winner != null ? "is winner" : 'is playing',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
            )
        );
      },
    );
  }
}
