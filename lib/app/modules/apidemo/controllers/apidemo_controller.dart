import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/survey_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ApidemoController extends GetxController {
  //TODO: Implement ApidemoController

  List<SurveydetailModel> getServeydetail() {
    List<SurveydetailModel> surveydetail = [];
     surveydetail.add(SurveydetailModel(
      'Màu yêu thích?', 
     [{"answer": "Red", "isCheck": false.obs},
      {"answer": "Blue", "isCheck": false.obs},
      {"answer": "Green", "isCheck": false.obs},],1));
     surveydetail.add(SurveydetailModel(
      'Màu ghét nhất?', 
     [{"answer": "Red", "isCheck": false.obs},
      {"answer": "Blue", "isCheck": false.obs},
      {"answer": "Green", "isCheck": false.obs},],1));
    return surveydetail;
  }

  var propertyList = <Map<String, dynamic>>[].obs;
  List<SurveydetailModel> surveyList = [];

Future<List<SurveydetailModel>?> fetchData() async {
  var url = Uri.parse('http://api.ctu-it.com/test.php');
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




  var isChecked = false.obs;

  
  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
