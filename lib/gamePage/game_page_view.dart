import 'package:checkers_game/levelsPage/components/levels_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/game_page_scaffold.dart';
import 'controller.dart';

class GamePageView extends StatelessWidget {
  final LevelsType? levelsType;
  const GamePageView({Key? key, required this.levelsType,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => GamePageController(levelsType),
      child: const GamePageScaffold(),
    );
  }
}
