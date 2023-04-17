import 'package:checkers_game/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'back_icon_widget.dart';
import 'general_text.dart';

AppBar generalAppBar({
  required String title,
  bool haveBackButton = true,
  Widget? extraWidgetInTitle,
  List<Widget>? actions,
  IconData? backIcon,
  Color color = Colors.white,
  Color backgroundColor = kSecondaryColor,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  double titleSize = 14,
  double elevation = 0.0,
  ShapeBorder? shapeBorder,
  void Function()? onTap,
}) =>
    AppBar(
      shape: shapeBorder,
      automaticallyImplyLeading: false,
      actions: actions,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: elevation,
      leading: haveBackButton? BackIconWidget(icon: backIcon ?? Icons.arrow_back_ios_new, color: color,): null,
      systemOverlayStyle: systemUiOverlayStyle,
      title: extraWidgetInTitle != null ? InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            extraWidgetInTitle,
            const SizedBox(width: 12,),
            GeneralText(text: title, isBold: true, color: color, size: titleSize,),
            const SizedBox(width: 24,),
          ],
        ),
      ):
      GeneralText(text: title, isBold: true, color: color, size: titleSize,),
      toolbarHeight: extraWidgetInTitle != null ? 80 : null,
    );