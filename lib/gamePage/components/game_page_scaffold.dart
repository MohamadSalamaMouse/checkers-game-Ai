import 'package:checkers_game/gamePage/components/board_component.dart';
import 'package:checkers_game/gamePage/components/current_player_component.dart';
import 'package:checkers_game/gamePage/components/winner_fireworks_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/main_layout_widget.dart';
import 'score_board_component.dart';

class GamePageScaffold extends StatelessWidget {
  const GamePageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      systemUiOverlayColor: SystemUiOverlayStyle.light,
      widthMargin: 0.0,
      heightMargin: 0.0,
      isScrollable: false,
      widget: Stack(
        alignment: Alignment.topCenter,
        children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ScoreBoardComponent(),
              SizedBox(height: 30),
              CurrentPlayerComponent(),
              SizedBox(height: 20),
              BoardComponent()
            ],
          ),
          const WinnerFireworksComponent(),
        ]
      )
    );
  }
}
