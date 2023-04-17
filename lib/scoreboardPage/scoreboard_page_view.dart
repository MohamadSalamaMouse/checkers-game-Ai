import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/scoreboard_page_scaffold.dart';
import 'controller.dart';

class ScoreboardPageView extends StatelessWidget {
  const ScoreboardPageView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => ScoreboardPageController()..onInit(),
      child: const ScoreboardPageScaffold(),
    );
  }
}
