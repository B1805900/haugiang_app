import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/survey_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SurveyDetailController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TODO: Implement SurveyDetailController
  
  List<SurveydetailModel> getServeydetail() {
    List<SurveydetailModel> surveydetail = [];
    surveydetail.add(SurveydetailModel('Màu yêu thích', ['Red', 'Blue', 'Green'],1));
    surveydetail.add(SurveydetailModel('Màu ghét nhất', ['Red', 'Blue', 'Green'],3));
    surveydetail.add(SurveydetailModel('Mùi thích nhất', ['Red', 'Blue', 'Green'],1));
    surveydetail.add(SurveydetailModel('Mùi ghét nhất', ['Red', 'Blue', 'Green'],3));
    return surveydetail;
  }

  var isChecked = false.obs;
  List<bool> checkedStates = [false, false, false];
  
  void toggleCheckbox(index) {
    isChecked.value = !isChecked.value;
    //checkedStates[index] = !checkedStates[index];
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
