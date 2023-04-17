import 'package:checkers_game/gamePage/models/ai_enemy_model.dart';
import 'package:checkers_game/gamePage/models/board_model.dart';
import 'package:checkers_game/levelsPage/components/levels_page_scaffold.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/easy_enemy_model.dart';
import 'models/piece_model.dart';
import 'state.dart';

class GamePageController extends Cubit<GamePageState>
{
  GamePageController(this.levelsType) :super(GamePageInit()){
    if(levelsType != null){
      if(levelsType == LevelsType.easy){
        aiEnemyModel = EasyEnemyModel(boardModel);
      }
    }
  }
  static GamePageController of(context)=> BlocProvider.of(context);
  final BoardModel boardModel = BoardModel();
  final ConfettiController confettiController = ConfettiController();
  final LevelsType? levelsType;
  AiEnemyModelInterface? aiEnemyModel;
  bool isEmpty(int x, int y){
    return boardModel.pieces[x][y] is EmptyPieceModel;
  }

  bool isMyTurn(OccupiedPieceModel piece){
    return boardModel.currentPlayer!.isWhite == piece.isWhite;
  }

  void onDragStarted(OccupiedPieceModel piece){
    boardModel.onDragStarted(piece);
    emit(GamePageInit());
  }

  void onDragEnded(OccupiedPieceModel piece, bool isAccepted){
    boardModel.onDragEnded(piece, isAccepted);
    emit(GamePageInit());
    if(boardModel.currentPlayer == boardModel.blackPLayer){
      aiEnemyModel?.onPlay();
    }
    if(boardModel.winner != null){
      confettiController.play();
      return;
    }
    emit(GamePageInit());
  }

  void onPlay(OccupiedPieceModel piece, PotentialPieceModel potentialPiece){
    boardModel.onPlay(piece, potentialPiece);
    emit(GamePageInit());
  }

  bool isThereAnOnlyPieceThatNeedToMove(PieceModel piece){
    return boardModel.onlyPieceThatCanEat != null &&( boardModel.onlyPieceThatCanEat!.x != piece.x || boardModel.onlyPieceThatCanEat!.y != piece.y);
  }

  @override
  Future<void> close() {
    confettiController.stop();
    confettiController.dispose();
    return super.close();
  }
}