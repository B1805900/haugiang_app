import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/survey_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SurveyDetailController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TODO: Implement SurveyDetailController
  final RxList<Map<String, dynamic>> selectedAnswers = <Map<String, dynamic>>[].obs;
  Future<List<SurveydetailModel>?> fetchData() async {
    var url = Uri.parse('http://api.ctu-it.com/API/surveydetail.php');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonDataList = json.decode(jsonString) as List<dynamic>;
        var fetchedSurveyList = <SurveydetailModel>[];
        for (var jsonData in jsonDataList) {
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
