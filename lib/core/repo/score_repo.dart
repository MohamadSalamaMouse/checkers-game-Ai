import 'package:checkers_game/core/models/score_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScoreRepo{
  Future<void> saveAScore(ScoreModel scoreModel) async {
    final previousScore = await _getScoreFromHive();
    previousScore.add(scoreModel.toJson());
    await Hive.box("user").put("score", previousScore);
  }

  Future<List<Map<String,dynamic>>> _getScoreFromHive() async {
    return Hive.box("user").get("score")??[];
  }

  Future<List<ScoreModel>> getScore() async {
    final previousScore = await _getScoreFromHive();
    return previousScore.map((e) => ScoreModel.fromJson(e)).toList();
  }
}