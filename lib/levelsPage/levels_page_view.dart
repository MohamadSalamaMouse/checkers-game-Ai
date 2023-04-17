import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/levels_page_scaffold.dart';

class LevelsPageView extends StatelessWidget {
  const LevelsPageView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return const LevelsPageScaffold();
  }
}
