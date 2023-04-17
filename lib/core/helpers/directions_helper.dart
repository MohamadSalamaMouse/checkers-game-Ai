import 'package:checkers_game/gamePage/models/board_model.dart';
import 'package:checkers_game/gamePage/models/piece_model.dart';
enum Directions {topLeft, topRight, bottomLeft, bottomRight}

class DirectionsHelper{
  BoardModel? boardModel;
  bool isAvailableTopLeft(PieceModel piece){
    return piece.x - 1 >= 0 && piece.y - 1 >= 0 && boardModel!.pieces[piece.x - 1][piece.y - 1] is EmptyPieceModel;
  }
  bool isAvailableTopRight(PieceModel piece){
    return piece.x + 1 < 8 && piece.y - 1 >= 0 && boardModel!.pieces[piece.x + 1][piece.y - 1] is EmptyPieceModel;
  }
  bool isAvailableBottomLeft(PieceModel piece){
    return piece.x - 1 >= 0 && piece.y + 1 < 8 && boardModel!.pieces[piece.x - 1][piece.y + 1] is EmptyPieceModel;
  }
  bool isAvailableBottomRight(PieceModel piece){
    return piece.x + 1 < 8 && piece.y + 1 < 8 && boardModel!.pieces[piece.x + 1][piece.y + 1] is EmptyPieceModel;
  }

  bool isDiagonal(PieceModel piece1, PieceModel piece2,) {
    int rowDiff = (piece1.x - piece2.x).abs();
    int colDiff = (piece1.y - piece2.y).abs();
    if (rowDiff == colDiff && rowDiff > 0 && colDiff > 0) {
      return true;
    } else {
      return false;
    }
  }


  PieceModel? isAvailableTopLeftKillAndReplace(OccupiedPieceModel piece){
    if(isAvailableTopLeft(piece)){
      return null;
    }
    int x = piece.x - 1;
    int y = piece.y - 1;
    return multiplePotentialKillsCreator(x, y, -1, -1, piece, (int x) => x - 1, (int y) => y - 1);
  }

  PieceModel? isAvailableTopRightKillAndReplace(OccupiedPieceModel piece){
    if(isAvailableTopRight(piece)){
      return null;
    }
    int x = piece.x + 1;
    int y = piece.y - 1;
    return multiplePotentialKillsCreator(x, y, 8, -1, piece, (int x) => x + 1, (int y) => y - 1);
  }

  PieceModel? isAvailableBottomLeftKillAndReplace(OccupiedPieceModel piece){
    if(isAvailableBottomLeft(piece)){
      return null;
    }
    int x = piece.x - 1;
    int y = piece.y + 1;
    return multiplePotentialKillsCreator(x, y, -1, 8, piece, (int x) => x - 1, (int y) => y + 1);
  }

  PieceModel? isAvailableBottomRightKillAndReplace(OccupiedPieceModel piece){
    if(isAvailableBottomRight(piece)){
      return null;
    }
    int x = piece.x + 1;
    int y = piece.y + 1;
    return multiplePotentialKillsCreator(x, y, 8, 8, piece, (int x) => x + 1, (int y) => y + 1);
  }

  PieceModel? multiplePotentialKillsCreator(int x , int y, int xLimit, int yLimit, OccupiedPieceModel piece, int Function(int) xChanger, int Function(int) yChanger){
    if(x < -1 || x > 8 || y < -1 || y > 8){
      return null;
    }
    PieceModel? potentialKill;
    int counter = 0;
    while(x != xLimit && y != yLimit){
      if( counter == 1 && boardModel!.pieces[x][y] is EmptyPieceModel){
        boardModel!.pieces[x][y] = PotentialPieceModel(x, y, isWhite: piece.isWhite,);
        return potentialKill;
      }
      else{
        if (boardModel!.pieces[x][y] is OccupiedPieceModel) {
          if ((boardModel!.pieces[x][y] as OccupiedPieceModel).isWhite != piece.isWhite) {
            counter++;
            potentialKill = boardModel!.pieces[x][y];
          } else {
            return null;
          }
        }
      }
      x = xChanger(x);
      y = yChanger(y);
    }
    return null;
  }

  PieceModel getPieceAfterAnotherPiece(OccupiedPieceModel piece, PieceModel otherPiece){
    try{
      int xDiff = 0;
      int yDiff = 0;
      if(piece.x < otherPiece.x){
        xDiff = piece.x - otherPiece.x + 1;
        yDiff = piece.y - otherPiece.y + 1;
      }
      else{
        xDiff = otherPiece.x - piece.x - 1;
        yDiff = otherPiece.y - piece.y - 1;
      }
      int x = piece.x + xDiff;
      int y = piece.y + yDiff;
      return boardModel!.pieces[x][y];
    }
    catch(e,t){
      print(e);
      print(t);
      return piece;
    }
  }

  PieceModel getPieceAfterWithADistance(OccupiedPieceModel piece, Directions direction, int distance){
    try{
      int xDiff = 0;
      int yDiff = 0;
      switch(direction){
        case Directions.topLeft:
          xDiff = -1;
          yDiff = -1;
          break;
        case Directions.topRight:
          xDiff = 1;
          yDiff = -1;
          break;
        case Directions.bottomLeft:
          xDiff = -1;
          yDiff = 1;
          break;
        case Directions.bottomRight:
          xDiff = 1;
          yDiff = 1;
          break;
      }
      int x = piece.x + xDiff * distance;
      int y = piece.y + yDiff * distance;
      return boardModel!.pieces[x][y];
    }
    catch(e,t){
      print(e);
      print(t);
      return piece;
    }
  }
}