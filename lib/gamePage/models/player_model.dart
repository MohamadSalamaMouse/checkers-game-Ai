import 'package:checkers_game/core/helpers/checkers.dart';
import 'package:equatable/equatable.dart';

import 'piece_model.dart';

class PLayerModel extends Equatable{
  List<OccupiedPieceModel> pieces = [];
  bool isWhite;
  bool get isBlack => !isWhite;
  int score = 0;
  PLayerModel({required this.isWhite}){
    _initPieces();
  }

  void _initPieces() {
    for (int y = isBlack ? 0 : 5; y < (isBlack ? 3 : 8); y++) {
      for (int x = 0; x < 8; x++) {
        if (!isRedSquare(x, y)) {
          // if(isWhite && y % 2 == 0) continue;
          pieces.add(OccupiedPieceModel(x,y, isWhite: isWhite,));
        }
      }
    }
  }

  @override
  List<Object?> get props => [isWhite];
}