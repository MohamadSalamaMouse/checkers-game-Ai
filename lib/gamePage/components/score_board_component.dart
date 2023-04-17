import 'package:checkers_game/constants.dart';
import 'package:checkers_game/gamePage/controller.dart';
import 'package:checkers_game/widgets/general_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreBoardComponent extends StatelessWidget {
  const ScoreBoardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageController gamePageController = GamePageController.of(context);
    return BlocBuilder(
      bloc: gamePageController,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const GeneralText(text: "Red", size: 28, isBold: true, color: kPrimaryColor,),
                  GeneralText(text: gamePageController.boardModel.whitePLayer.score.toString(), size: 16, isBold: true, color: Colors.white,),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const GeneralText(text: "Black", size: 28, isBold: true, color: Colors.white,),
                  GeneralText(text: gamePageController.boardModel.blackPLayer.score.toString(), size: 16, isBold: true, color: Colors.white,),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
