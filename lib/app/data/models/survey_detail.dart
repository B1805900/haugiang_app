class SurveydetailModel {
  int? idQuestion;
  String? question;
  int? type;
  List<Map<String, dynamic>>? answers;

  SurveydetailModel(
    this.question,
    this.answers,
    this.type,
  );
}
