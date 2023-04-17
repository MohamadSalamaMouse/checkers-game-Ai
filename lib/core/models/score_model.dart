class ScoreModel{
  int whiteScore;
  int blackScore;
  String type;
  String get winner => whiteScore == 12 ? 'White' : 'Black';
  ScoreModel(this.blackScore, this.whiteScore, this.type);
  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      json['blackScore'],
      json['whiteScore'],
      json['type'],
    );
  }
  factory ScoreModel.fromLocalMatch(int blackScore, int whiteScore){
    return ScoreModel(
      blackScore,
      whiteScore,
      "local",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blackScore': blackScore,
      'whiteScore': whiteScore,
      'type': type,
    };
  }
}