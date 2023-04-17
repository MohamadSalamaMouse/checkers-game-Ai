import 'package:checkers_game/core/helpers/directions_helper.dart';
import 'package:checkers_game/gamePage/models/board_model.dart';

abstract class AiEnemyModelInterface{
  BoardModel boardModel;
  DirectionsHelper get directionsHelper{
    return boardModel.directionsHelper;
  }
  AiEnemyModelInterface(this.boardModel);

  void onPlay();
}
