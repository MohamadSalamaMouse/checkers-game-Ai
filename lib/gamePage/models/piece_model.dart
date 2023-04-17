import 'package:checkers_game/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PieceModel extends Equatable{
  int x;
  int y;
  PieceModel(this.x, this.y,);
  @override
  List<Object?> get props => [x, y,];
}

class EmptyPieceModel extends PieceModel{
  EmptyPieceModel(super.x, super.y);
}

class OccupiedPieceModel extends PieceModel{
  bool isWhite;
  bool get isBlack => !isWhite;
  OccupiedPieceModel(super.x, super.y, {required this.isWhite,});

  Color get color => isWhite ? kPrimaryColor : kSecondaryColor;
}

class KingPieceModel extends OccupiedPieceModel{
  KingPieceModel(super.x, super.y, {required super.isWhite});
}

class PotentialPieceModel extends OccupiedPieceModel{
  PotentialPieceModel(super.x, super.y, {required super.isWhite});
}
