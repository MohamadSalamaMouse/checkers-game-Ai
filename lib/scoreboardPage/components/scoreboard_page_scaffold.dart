import 'package:checkers_game/scoreboardPage/components/previous_scores_component.dart';
import 'package:checkers_game/scoreboardPage/controller.dart';
import 'package:checkers_game/scoreboardPage/state.dart';
import 'package:checkers_game/widgets/general_app_bar_widget.dart';
import 'package:checkers_game/widgets/general_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/main_layout_widget.dart';

class ScoreboardPageScaffold extends StatelessWidget {
  const ScoreboardPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScoreboardPageController blocController = ScoreboardPageController.of(context);
    return MainLayoutWidget(
      systemUiOverlayColor: SystemUiOverlayStyle.light,
      widthMargin: 30,
      isScrollable: false,
      extendBodyBehindAppBar: true,
      appBar: generalAppBar(title: "Scoreboard",),
      widget: BlocBuilder(
        bloc: blocController,
        builder: (context, state) {
          if(state is ScoreboardPageLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(blocController.scores.isEmpty) {
            return const Center(child: GeneralText(text: "No scores yet", size: 24,),);
          }
          return const PreviousScoresComponent();
        },
      ),
    );
  }
}
