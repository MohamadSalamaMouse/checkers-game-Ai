import 'package:checkers_game/core/models/score_model.dart';
import 'package:checkers_game/core/repo/score_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class ScoreboardPageController extends Cubit<ScoreboardPageState>
{
  ScoreboardPageController() :super(ScoreboardPageInit());
  static ScoreboardPageController of(context)=> BlocProvider.of(context);
  List<ScoreModel> scores = [];

  void onInit() async {
    emit(ScoreboardPageLoading());
    scores = (await ScoreRepo().getScore()).reversed.toList();
    emit(ScoreboardPageDone());
  }

}