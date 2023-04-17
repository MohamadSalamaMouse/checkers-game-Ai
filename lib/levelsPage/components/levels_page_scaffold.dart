import 'package:checkers_game/core/helpers/navigation_helper.dart';
import 'package:checkers_game/gamePage/game_page_view.dart';
import 'package:checkers_game/widgets/general_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/main_layout_widget.dart';

enum LevelsType{
  easy,
  medium,
  hard,
}

class LevelsPageScaffold extends StatelessWidget {
  const LevelsPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      systemUiOverlayColor: SystemUiOverlayStyle.light,
      widthMargin: 30,
      isScrollable: false,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GeneralButton(text: "Easy", onPressed: ()=> NavigationHelper.pushAndReplacement(context, const GamePageView(levelsType: LevelsType.easy,)),),
          GeneralButton(text: "Medium", onPressed: ()=> NavigationHelper.pushAndReplacement(context, const GamePageView(levelsType: LevelsType.medium,)),),
          GeneralButton(text: "Hard", onPressed: ()=> NavigationHelper.pushAndReplacement(context, const GamePageView(levelsType: LevelsType.hard,)),),
        ],
      ),
    );
  }
}
