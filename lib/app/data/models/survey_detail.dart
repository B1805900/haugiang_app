class SurveydetailModel {
  String? idGroup;
  String? groupName;
  List<QuestionModel>? questions;

  SurveydetailModel(this.idGroup, this.groupName, this.questions);

  factory SurveydetailModel.fromJson(Map<String, dynamic> json) {
    List<QuestionModel> questions = (json['questions'] as List<dynamic>)
        .map((questionJson) => QuestionModel.fromJson(questionJson))
        .toList();

    return SurveydetailModel(
      json['id_group'],
      json['group_name'],
      questions,
    );
  }
}

class QuestionModel {
  String? idQuestion;
  String? question;
  int? type;
  List<Map<String, dynamic>>? answers;

  QuestionModel(this.idQuestion, this.question, this.type, this.answers);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> answerList = (json['answers'] as List<dynamic>)
        .map((answer) => {'answer': answer.toString(), 'isCheck': false})
        .toList();

    return QuestionModel(
      json['id_question'],
      json['question'],
      json['type'],
      answerList,
    );
  }
}
