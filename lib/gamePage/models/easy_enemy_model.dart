import 'package:checkers_game/core/models/score_model.dart';
import 'package:checkers_game/core/repo/score_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:checkers_game/core/helpers/directions_helper.dart';
import 'package:checkers_game/gamePage/models/ai_enemy_model.dart';

import 'board_model.dart';
import 'piece_model.dart';

class EasyEnemyModel implements AiEnemyModelInterface{
  @override
  BoardModel boardModel;
  @override
  DirectionsHelper get directionsHelper => boardModel.directionsHelper;

  EasyEnemyModel(this.boardModel);

  @override
  void onPlay() {
    Tuple4<bool, OccupiedPieceModel?, OccupiedPieceModel?, EmptyPieceModel?> resultOfCheckForKill = checkForKill();
    if(resultOfCheckForKill.value1){
      killAPiece(resultOfCheckForKill);
      checkIfAiWon();
      boardModel.switchPlayer();
      return;
    }
    Tuple3<bool, OccupiedPieceModel?, EmptyPieceModel?> move = checkForAMove();
    if(move.value1){
      moveAPiece(move);
      checkIfAiWon();
      boardModel.switchPlayer();
      return;
    }
    boardModel.winner = boardModel.whitePLayer;
    ScoreRepo().saveAScore(ScoreModel(boardModel.blackPLayer.score, boardModel.whitePLayer.score, "easy"),);
  }
  void checkIfAiWon(){
    if(boardModel.blackPLayer.score == 12){
      boardModel.winner = boardModel.blackPLayer;
      ScoreRepo().saveAScore(ScoreModel(boardModel.blackPLayer.score, boardModel.whitePLayer.score, "easy"),);
    }
  }
  //....isKill, winner piece,    eaten piece,         empty piece
  Tuple4<bool,OccupiedPieceModel?,OccupiedPieceModel?,EmptyPieceModel?> checkForKill(){
    for(int x = 0; x < 8; x++){
      for(int y = 0; y < 8; y++){
        PieceModel currentPiece = boardModel.pieces[x][y];
        if(currentPiece is OccupiedPieceModel && currentPiece.isBlack){
          //I'm checking is there a kill on the left bottom
          if(x > 1){
            //for the king
            if(y > 1 && currentPiece is KingPieceModel){
              PieceModel topLeft = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.topLeft, 1);
              if(topLeft is OccupiedPieceModel && topLeft.isWhite){
                PieceModel topLeftKill = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.topLeft, 2);
                if(topLeftKill is EmptyPieceModel){
                  return Tuple4(true, currentPiece,topLeft, topLeftKill);
                }
              }
            }
            if(y < 6){
              PieceModel bottomLeft = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.bottomLeft, 1);
              if(bottomLeft is OccupiedPieceModel && bottomLeft.isWhite){
                PieceModel bottomLeftKill = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.bottomLeft, 2);
                if(bottomLeftKill is EmptyPieceModel){
                  return Tuple4(true,currentPiece ,bottomLeft, bottomLeftKill);
                }
              }
            }
          }
          //I'm checking is there a kill on the right bottom
          if(x < 6){
            //for the king
            if(y > 1 && currentPiece is KingPieceModel){
              PieceModel topRight = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.topRight, 1);
              if(topRight is OccupiedPieceModel && topRight.isWhite){
                PieceModel topRightKill = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.topRight, 2);
                if(topRightKill is EmptyPieceModel){
                  return Tuple4(true, currentPiece,topRight, topRightKill);
                }
              }
            }
            if(y < 6){
              PieceModel bottomRight = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.bottomRight, 1);
              if(bottomRight is OccupiedPieceModel && bottomRight.isWhite){
                PieceModel bottomRightKill = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.bottomRight, 2);
                if(bottomRightKill is EmptyPieceModel){
                  return Tuple4(true, currentPiece,bottomRight, bottomRightKill);
                }
              }
            }
          }
        }
      }
    }
    return const Tuple4(false, null,null, null);
  }

  void killAPiece(Tuple4<bool,OccupiedPieceModel?,OccupiedPieceModel?,EmptyPieceModel?> kill){
    OccupiedPieceModel piece = kill.value2!;
    OccupiedPieceModel eatenPiece = kill.value3!;
    EmptyPieceModel emptyPiece = kill.value4!;
    boardModel.pieces[eatenPiece.x][eatenPiece.y] = EmptyPieceModel(eatenPiece.x, eatenPiece.y);
    if(piece is KingPieceModel|| emptyPiece.y == 7){
      boardModel.pieces[emptyPiece.x][emptyPiece.y] = KingPieceModel(emptyPiece.x, emptyPiece.y, isWhite: piece.isWhite);
    }
    else {
      boardModel.pieces[emptyPiece.x][emptyPiece.y] = OccupiedPieceModel(emptyPiece.x, emptyPiece.y, isWhite: piece.isWhite);
    }
    boardModel.pieces[piece.x][piece.y] = EmptyPieceModel(piece.x, piece.y);
    boardModel.currentPlayer?.score++;
  }

  Tuple3<bool, OccupiedPieceModel?, EmptyPieceModel?> checkForAMove(){
    for(int x = 0; x < 8; x++){
      for(int y = 0; y < 7; y++){
        PieceModel currentPiece = boardModel.pieces[x][y];
        if(currentPiece is OccupiedPieceModel && currentPiece.isBlack){
          if(x != 0){
            PieceModel bottomLeft = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.bottomLeft, 1);
            if(bottomLeft is EmptyPieceModel){
              return Tuple3(true, currentPiece, bottomLeft);
            }
          }
          if(x != 7){
            PieceModel bottomRight = directionsHelper.getPieceAfterWithADistance(currentPiece, Directions.bottomRight, 1);
            if(bottomRight is EmptyPieceModel){
              return Tuple3(true, currentPiece, bottomRight);
            }
          }
        }
      }
    }
    return const Tuple3(false, null, null);
  }

  void moveAPiece(Tuple3<bool, OccupiedPieceModel?, EmptyPieceModel?> move){
    OccupiedPieceModel piece = move.value2!;
    EmptyPieceModel emptyPiece = move.value3!;
    if(piece is KingPieceModel || emptyPiece.y == 7){
      boardModel.pieces[emptyPiece.x][emptyPiece.y] = KingPieceModel(emptyPiece.x, emptyPiece.y, isWhite: piece.isWhite);
    }
    else {
      boardModel.pieces[emptyPiece.x][emptyPiece.y] = OccupiedPieceModel(emptyPiece.x, emptyPiece.y, isWhite: false,);
    }
    boardModel.pieces[piece.x][piece.y] = EmptyPieceModel(piece.x, piece.y);
  }

}