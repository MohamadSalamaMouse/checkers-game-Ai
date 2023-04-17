import 'package:checkers_game/scoreboardPage/controller.dart';
import 'package:checkers_game/scoreboardPage/widgets/score_widget.dart';
import 'package:flutter/material.dart';

class PreviousScoresComponent extends StatelessWidget {
  const PreviousScoresComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreboardPageController blocController = ScoreboardPageController.of(context);
    return ListView.builder(
      itemCount: blocController.scores.length,
      itemBuilder: (context, index) {
        return ScoreWidget(scoreModel: blocController.scores[index]);
      },
    );
  }
}
