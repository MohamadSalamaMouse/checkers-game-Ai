import 'package:flutter/material.dart';
import '../constants.dart';
import '../main.dart';

void showLoading({Color? loadingColor})
{
  showDialog<String>(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) =>
      WillPopScope (
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(
            child: Container(
              padding: const EdgeInsets.all(16,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16,),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  )
                ],
              ),
              child: CircularProgressIndicator(
                color: loadingColor??kPrimaryColor,
              ),
            )
          ),
        ),
      )
  );
}
void hideLoading() => Navigator.pop(navigatorKey.currentContext!);