import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../../data/models/survey.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  


  final scaffoldKey = GlobalKey<ScaffoldState>();

  var propertyList = <Map<String, dynamic>>[].obs;
  List<SurveyModel> surveyList = [];
  
  Future<List<SurveyModel>> fetchData() async {
    var url = Uri.parse('http://api.ctu-it.com/survey.php');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonDataList = jsonString.split('}{');
        jsonDataList = jsonDataList.map((jsonString) {
          if (!jsonString.startsWith('{')) jsonString = '{' + jsonString;
          if (!jsonString.endsWith('}')) jsonString += '}';
          return jsonString;
        }).toList();

        var properties = <Map<String, dynamic>>[];
        for (var jsonData in jsonDataList) {
          var property = json.decode(jsonData);
          properties.add(property);
          surveyList.add(SurveyModel(property['id_survey'], property['name_survey'], property['time_create']['date'].substring(0, 10), property['time_end']['date'].substring(0, 10), property['username']));
        }
        propertyList.value = properties;
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
    }

      // Trả về null hoặc giá trị khác để biểu thị lỗi
    return surveyList;
  }

  //TODO: Implement DashboardController
    List<SurveyModel> getSurveyList() {
    List<SurveyModel> surveyList = [];
    surveyList.add(SurveyModel('ID Khảo sát', 'Tên Khảo sát', 'Thời gian tạo', 'Thời gian kết thúc', 'ID người tạo'));
    surveyList.add(SurveyModel('#00001', 'Đánh giá thủ tục làm CCCD', '27/05/2023', '27/06/2023', '003'));
    return surveyList;
  }
  final count = 0.obs;
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

  void increment() => count.value++;
}
