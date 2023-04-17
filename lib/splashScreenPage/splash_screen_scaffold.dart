import 'dart:developer';
import 'package:checkers_game/core/helpers/navigation_helper.dart';
import 'package:checkers_game/widgets/general_text.dart';
import 'package:checkers_game/widgets/main_layout_widget.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../mainPage/main_page_view.dart';
import '../size_config.dart';

class SplashScreenScaffold extends StatefulWidget {
  const SplashScreenScaffold({Key? key}) : super(key: key);

  @override
  State<SplashScreenScaffold> createState() => _SplashScreenScaffoldState();
}

class _SplashScreenScaffoldState extends State<SplashScreenScaffold> {
  @override
  void initState() {
    super.initState();
    //this is the function which contains all the settings need to be done before starting the app
    delayingFunc();
  }

  void delayingFunc() async {
    try {
      await Future.delayed(const Duration(seconds: 3),);
      NavigationHelper.pushUntil(context, const MainPageView());
    } catch (e, trace) {
      log(e.toString());
      log(trace.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MainLayoutWidget(
      backGroundColor: kPrimaryColor,
      isScrollable: false,
      widthMargin: 0.0,
      heightMargin: 0.0,
      widget: Stack(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Wrap(
              children: const [
                BoxesWidget(color: kPrimaryColor,),
                BoxesWidget(color: kSecondaryColor,),
                BoxesWidget(color: kSecondaryColor,),
                BoxesWidget(color: kPrimaryColor,),
                BoxesWidget(color: kPrimaryColor,),
                BoxesWidget(color: kSecondaryColor,),
                BoxesWidget(color: kSecondaryColor,),
                BoxesWidget(color: kPrimaryColor,),
              ]
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              GeneralText(
                text: "The Cheky checkers",
                size: 39,
                color: Colors.white,
                textAlign: TextAlign.center,
                isBold: true,
              ),
            ],
          ),
        ],
      )
    );
  }
}

class BoxesWidget extends StatelessWidget {
  final Color color;
  const BoxesWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth *0.5,
      height: SizeConfig.screenHeight *0.25,
      color: color,
    );
  }
}
