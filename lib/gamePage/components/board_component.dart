import 'package:checkers_game/core/helpers/checkers.dart';
import 'package:checkers_game/core/helpers/dimensions_helper.dart';
import 'package:checkers_game/gamePage/widgets/color_boxes_widget.dart';
import 'package:checkers_game/gamePage/widgets/piece_widget.dart';
import 'package:flutter/material.dart';

class BoardComponent extends StatelessWidget {
  final DimensionsHelper dimensionsHelper = const DimensionsHelper();

  const BoardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(
        8,
        (y) => Row(
          children: List.generate(
            8,
            (x) => Stack(
              children: [
                ColorBoxesWidget(
                  color: isRedSquare(x,y) ? Colors.white : Colors.green,
                  x: x,
                  y: y,
                ),
                PieceWidget(x: x, y: y),
              ],
            )
          ),
        ),
      ),
    );
  }
}

