import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/main_page_scaffold.dart';
import 'controller.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => MainPageController(),
      child: const MainPageScaffold(),
    );
  }
}
