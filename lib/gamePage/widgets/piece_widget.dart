import 'package:checkers_game/core/helpers/dimensions_helper.dart';
import 'package:checkers_game/gamePage/controller.dart';
import 'package:checkers_game/gamePage/models/piece_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PieceWidget extends StatelessWidget {
  final int x;
  final int y;
  final DimensionsHelper dimensionsHelper = const DimensionsHelper();

  const PieceWidget({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageController blocController = GamePageController.of(context);
    return BlocBuilder(
      bloc: blocController,
      builder: (context, state) {
        if (blocController.isEmpty(x, y)) return const SizedBox();
        OccupiedPieceModel piece =
            blocController.boardModel.pieces[x][y] as OccupiedPieceModel;
        return Container(
            width: dimensionsHelper.x / 8,
            height: dimensionsHelper.x / 8,
            alignment: Alignment.center,
            child: () {
              if (piece is PotentialPieceModel) {
                return DragTarget<PieceModel>(
                  builder: (context, List<PieceModel?> pieceModels, List list) {
                    return Container(
                      alignment: Alignment.center,
                      width: (dimensionsHelper.x / 8) + 100,
                      height: dimensionsHelper.x / 8 + 100,
                      child: Opacity(
                        opacity: 0.5,
                        child: CoinWidget(piece: piece),
                      ),
                    );
                  },
                  onAccept: (data) {
                    blocController.onPlay(data as OccupiedPieceModel, piece);
                    blocController.onDragEnded(piece, true);
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                );
              }
              if (!blocController.isMyTurn(piece)) {
                return CoinWidget(piece: piece);
              }
              if(blocController.isThereAnOnlyPieceThatNeedToMove(piece)) {
                return CoinWidget(piece: piece);
              }
              return Draggable<PieceModel>(
                data: piece,
                feedback: CoinWidget(piece: piece, isFeedback: true, color: blocController.boardModel.onlyPieceThatCanEat != null ? Colors.orange : null,),
                childWhenDragging: const SizedBox(),
                onDragStarted: () => blocController.onDragStarted(piece),
                onDragEnd: (details) {
                  if (!details.wasAccepted) {
                    blocController.onDragEnded(piece, false);
                  }
                },
                child: CoinWidget(piece: piece, color: blocController.boardModel.onlyPieceThatCanEat != null ? Colors.orange : null,),
              );
            }());
      },
    );
  }
}

class CoinWidget extends StatelessWidget {
  final OccupiedPieceModel piece;
  final bool isFeedback;
  final Color? color;
  final DimensionsHelper dimensionsHelper = const DimensionsHelper();

  const CoinWidget({Key? key, required this.piece, this.isFeedback = false, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dimension = (dimensionsHelper.x / 8) - (isFeedback ? -14 : 14);
    return Stack(
      children: [
        Container(
          width: dimension,
          height: dimension,
          decoration: BoxDecoration(
            color: color??piece.color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
        ),
        if (piece is KingPieceModel)
          Container(
            width: dimension,
            height: dimension,
            alignment: Alignment.center,
            child: Image.asset(
              "assets/crown.png",
            ),
          ),
      ],
    );
  }
}
