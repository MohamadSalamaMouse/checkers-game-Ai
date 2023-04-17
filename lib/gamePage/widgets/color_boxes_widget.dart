import 'package:checkers_game/core/helpers/dimensions_helper.dart';
import 'package:flutter/material.dart';

class ColorBoxesWidget extends StatelessWidget {
  final Color color;
  final DimensionsHelper dimensionsHelper = const DimensionsHelper();
  final int x;
  final int y;
  const ColorBoxesWidget({Key? key, required this.color, required this.x, required this.y}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimensionsHelper.x / 8,
      height: dimensionsHelper.x / 8,
      color: color,
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text("X : $x", ),
      //     Text("y : $y"),
      //   ],
      // ),
    );
  }
}