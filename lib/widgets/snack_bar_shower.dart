import 'package:flutter/material.dart';
import '../main.dart';

void snackBarShower(String text, {EdgeInsets? margin})
{
  final snackBar = SnackBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),)
      ),
      backgroundColor: Colors.grey.shade300,
    behavior: margin != null ? SnackBarBehavior.floating : null,
      content:  Text(text ,style: const TextStyle(color: Colors.black,), textAlign: TextAlign.center, textDirection: TextDirection.rtl,),
      margin: margin,
  );
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
}