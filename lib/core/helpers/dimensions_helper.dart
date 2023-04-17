import 'dart:math' as math;

import 'package:checkers_game/size_config.dart';
class DimensionsHelper{
  const DimensionsHelper();
  double get x => math.min(SizeConfig.screenWidth, SizeConfig.screenHeight);

  double get y => math.min(SizeConfig.screenWidth, SizeConfig.screenHeight);
}