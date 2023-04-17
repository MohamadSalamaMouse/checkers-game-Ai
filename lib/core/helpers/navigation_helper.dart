import 'package:flutter/material.dart';

class NavigationHelper {


  static void navigation(BuildContext context, var destination,String routeType){
    if(routeType == 'push'){
      push(context, destination);
    }
    else if(routeType == 'pushAndReplacement'){
      pushAndReplacement(context, destination);
    }
    else{
      pushUntil(context, destination);
    }
  }
  static Future<void> push(BuildContext context, var destination, {bool fullscreenDialog = false}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => destination,
      ),
    );
  }

  static Future<void> pushAndReplacement(BuildContext context, var destination) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => destination,
      ),
    );
  }

  static Future<void> pushUntil(BuildContext context, var destination, {bool fullscreenDialog = false}) async {
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => destination,
        ),
            (Route<dynamic> route) => false
    );
  }

}

