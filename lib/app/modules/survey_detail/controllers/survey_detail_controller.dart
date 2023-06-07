import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/survey_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/models/result.dart';


class SurveyDetailController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var cccdNum;
  var idSurveyNum;
  //TODO: Implement SurveyDetailController
  final List<ResultModel> resultList = <ResultModel>[];
  void addResult(String? cccd, String? idSurvey, String? idQuestion, String? answer) {
      resultList.add(ResultModel(
        cccd: cccd,
        idSurvey: idSurvey,
        idQuestion: idQuestion,
        answer: answer,
      ));
  }

  Future<List<SurveydetailModel>?> fetchData() async {
    var url = Uri.parse('http://api.ctu-it.com/API/surveydetail.php?id_survey=$idSurveyNum');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonDataList = json.decode(jsonString) as List<dynamic>;
        var fetchedSurveyList = <SurveydetailModel>[];
        for (var jsonData in jsonDataList) {
          var idQuestion = jsonData['id_question'] as String;
          var question = jsonData['question'] as String;
          var answers = (jsonData['answers'] as List<dynamic>).cast<String>();
          var type = jsonData['type'] as int;

          fetchedSurveyList.add(
            SurveydetailModel(
              question,
              answers
                  .map(
                    (answer) => {'answer': answer, 'isCheck': false.obs},
                  )
                  .toList(),
              type,
              idQuestion,
            ),
          );
        }
        return fetchedSurveyList;
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
      } catch (e) {
        print('Lỗi khi gọi API: $e');
      }

      // Trả về null hoặc giá trị khác để biểu thị lỗi
      return null;
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
