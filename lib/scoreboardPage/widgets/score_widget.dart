import 'package:checkers_game/constants.dart';
import 'package:checkers_game/core/extensions/string_extensions.dart';
import 'package:checkers_game/core/models/score_model.dart';
import 'package:checkers_game/widgets/general_text.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  final ScoreModel scoreModel;
  const ScoreWidget({Key? key, required this.scoreModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const GeneralText(text: "You", size: 24, isBold: true,),
              const SizedBox(height: 12,),
              GeneralText(text: "${scoreModel.whiteScore}", size: 20,),
            ],
          ),
          const GeneralText(text: "VS", size: 24, isBold: true, color: kPrimaryColor),
          Column(
            children: [
              GeneralText(text: scoreModel.type.upperCaseFirstLetter(), size: 24, isBold: true,),
              const SizedBox(height: 12,),
              GeneralText(text: "${scoreModel.blackScore}", size: 20,),
            ],
          ),
        ],
      )
    );
  }
}
