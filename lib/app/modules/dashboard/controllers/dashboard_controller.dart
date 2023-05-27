import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/models/survey.dart';

class DashboardController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TODO: Implement DashboardController
    List<SurveyModel> getSurveyList() {
    List<SurveyModel> surveyList = [];
    // SurveyModel ks1 = SurveyModel('ID Khảo sát', 'Tên Khảo sát', 'Thời gian tạo', 'Thời gian kết thúc', 'ID người tạo');
    // SurveyModel ks2 = SurveyModel('#00001', 'Đánh giá thủ tục làm CCCD', '27/05/2023', '27/06/2023', '003');
    surveyList.add(SurveyModel('ID Khảo sát', 'Tên Khảo sát', 'Thời gian tạo', 'Thời gian kết thúc', 'ID người tạo'));
    surveyList.add(SurveyModel('#00001', 'Đánh giá thủ tục làm CCCD', '27/05/2023', '27/06/2023', '003'));

    // await for (var classRoomSnapshot in classRoomsStream) {
    //   classRooms.clear();
    //   for (var classRoomDoc in classRoomSnapshot.docs) {
    //     var classRoom = classRoomDoc.data();
    //     var classRoomModel = ClassroomModel.fromJson(classRoom);

    //     classRooms.add(classRoomModel);
    //   }
    //   yield classRooms;
    // }
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
