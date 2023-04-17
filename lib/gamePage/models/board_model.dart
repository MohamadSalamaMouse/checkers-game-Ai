import 'package:checkers_game/core/helpers/directions_helper.dart';
import 'package:checkers_game/core/models/score_model.dart';
import 'package:checkers_game/core/repo/score_repo.dart';
import 'package:checkers_game/gamePage/models/player_model.dart';

import 'piece_model.dart';

class BoardModel{
  DirectionsHelper directionsHelper = DirectionsHelper();
  List<List<PieceModel>> pieces = [];
  PLayerModel whitePLayer = PLayerModel(isWhite: true);
  PLayerModel blackPLayer = PLayerModel(isWhite: false);
  PLayerModel? currentPlayer;
  List<PieceModel> eatenPieces = [];
  bool hasEaten = false;
  OccupiedPieceModel? onlyPieceThatCanEat;
  PLayerModel? winner;
  BoardModel(){
    currentPlayer = whitePLayer;
    directionsHelper.boardModel = this;
    for (int x = 0; x < 8; x++) {
      pieces.add([]);
      for (int y = 0; y < 8; y++) {
        pieces[x].add(EmptyPieceModel(x, y));
      }
    }
    for (final piece in whitePLayer.pieces) {
      pieces[piece.x][piece.y] = piece;
    }
    for (final piece in blackPLayer.pieces) {
      pieces[piece.x][piece.y] = piece;
    }
  }

  void onDragStarted(OccupiedPieceModel piece){
    createPotentialMoves(piece);
    createPotentialKills(piece);
  }

  void createPotentialMoves(OccupiedPieceModel piece){
    if(piece.isWhite || piece is KingPieceModel){
      if(directionsHelper.isAvailableTopLeft(piece)){
        pieces[piece.x - 1][piece.y - 1] = PotentialPieceModel(piece.x - 1, piece.y - 1, isWhite: piece.isWhite,);
      }
      if(directionsHelper.isAvailableTopRight(piece)){
        pieces[piece.x + 1][piece.y - 1] = PotentialPieceModel(piece.x + 1, piece.y - 1, isWhite: piece.isWhite,);
      }
    }
    if(piece.isBlack || piece is KingPieceModel){
      if(directionsHelper.isAvailableBottomLeft(piece)){
        pieces[piece.x - 1][piece.y + 1] = PotentialPieceModel(piece.x - 1, piece.y + 1, isWhite: piece.isWhite,);
      }
      if(directionsHelper.isAvailableBottomRight(piece)){
        pieces[piece.x + 1][piece.y + 1] = PotentialPieceModel(piece.x + 1, piece.y + 1, isWhite: piece.isWhite,);
      }
    }
  }

  void createPotentialKills(OccupiedPieceModel piece){
    if(piece is KingPieceModel || piece.isWhite){
      PieceModel? topLeft = directionsHelper.isAvailableTopLeftKillAndReplace(piece);
      if(topLeft != null){
        eatenPieces.add(topLeft);
      }
      PieceModel? topRight = directionsHelper.isAvailableTopRightKillAndReplace(piece);
      if(topRight != null){
        eatenPieces.add(topRight);
      }
    }
    if(piece is KingPieceModel || piece.isBlack){
      PieceModel? bottomLeft = directionsHelper.isAvailableBottomLeftKillAndReplace(piece);
      if(bottomLeft != null){
        eatenPieces.add(bottomLeft);
      }
      PieceModel? bottomRight = directionsHelper.isAvailableBottomRightKillAndReplace(piece);
      if(bottomRight != null){
        eatenPieces.add(bottomRight);
      }
    }
  }

  void onDragEnded(OccupiedPieceModel piece, bool isAccepted){
    if(isAccepted){
      onlyPieceThatCanEat = null;
      for (final eatenPiece in eatenPieces) {
        if(directionsHelper.isDiagonal(piece, eatenPiece)) {
          hasEaten = true;
          pieces[eatenPiece.x][eatenPiece.y] = EmptyPieceModel(eatenPiece.x, eatenPiece.y);
        }
        else{
          if(pieces[eatenPiece.x][eatenPiece.y] is KingPieceModel){
            pieces[eatenPiece.x][eatenPiece.y] = KingPieceModel(eatenPiece.x, eatenPiece.y, isWhite: !piece.isWhite);
          }
          else {
            pieces[eatenPiece.x][eatenPiece.y] = OccupiedPieceModel(eatenPiece.x, eatenPiece.y, isWhite: !piece.isWhite);
          }
        }
      }
      if(hasEaten && eatenPieces.isNotEmpty){
        currentPlayer!.score += eatenPieces.length;
      }
    }
    eatenPieces.clear();
    if(hasEaten) {
      checkIfThereIsAnotherKill(piece);
      hasEaten = false;
    }
    if(isAccepted) switchPlayer();
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        if(pieces[x][y] is PotentialPieceModel){
          pieces[x][y] = EmptyPieceModel(x, y);
        }
      }
    }
    checkIfThereAWinner();
  }

  void onPlay(OccupiedPieceModel piece, PotentialPieceModel potentialPiece){
    pieces[piece.x][piece.y] = EmptyPieceModel(piece.x, piece.y);
    if(potentialPiece.y == 0 || potentialPiece.y == 7 || piece is KingPieceModel){
      pieces[potentialPiece.x][potentialPiece.y] = KingPieceModel(potentialPiece.x, potentialPiece.y, isWhite: piece.isWhite,);
    }
    else {
      pieces[potentialPiece.x][potentialPiece.y] = OccupiedPieceModel(potentialPiece.x, potentialPiece.y, isWhite: piece.isWhite,);
    }
  }

  void checkIfThereIsAnotherKill(OccupiedPieceModel piece){
    createPotentialKills(piece);
    if(eatenPieces.length == 1){
      PieceModel eatenPiece = eatenPieces[0];
      PieceModel pieceAfterEaten = directionsHelper.getPieceAfterAnotherPiece(piece, eatenPiece);
      PotentialPieceModel potentialPieceModel = pieces[pieceAfterEaten.x][pieceAfterEaten.y] = PotentialPieceModel(pieceAfterEaten.x, pieceAfterEaten.y, isWhite: piece.isWhite,);
      onPlay(piece, potentialPieceModel);
      onDragEnded(piece, true);
      pieces[eatenPiece.x][eatenPiece.y] = EmptyPieceModel(eatenPiece.x, eatenPiece.y);
    }
    else if(eatenPieces.length == 2){
      switchPlayer();
      onlyPieceThatCanEat = piece;
    }
    eatenPieces.clear();
  }

  void switchPlayer(){
    currentPlayer = currentPlayer == whitePLayer ? blackPLayer : whitePLayer;
  }

  void checkIfThereAWinner() {
    if (whitePLayer.score == 12) {
      winner = whitePLayer;
      ScoreRepo().saveAScore(ScoreModel.fromLocalMatch(blackPLayer.score, whitePLayer.score,),);
      switchPlayer();
    } else if (blackPLayer.score == 12) {
      winner = blackPLayer;
      ScoreRepo().saveAScore(ScoreModel.fromLocalMatch(blackPLayer.score, whitePLayer.score,),);
      switchPlayer();
    }
  }
}