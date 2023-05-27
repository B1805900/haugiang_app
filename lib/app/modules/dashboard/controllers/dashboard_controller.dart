import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/models/classroom.dart';

class DashboardController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TODO: Implement DashboardController
    List<SurveyModel> getClassRoom() {
    List<SurveyModel> classRooms = [];
    SurveyModel ks1 = SurveyModel('a', 'b', 'c', 'd', 'e');
    print(ks1.nameSurvey);
    classRooms.add(ks1);
    // await for (var classRoomSnapshot in classRoomsStream) {
    //   classRooms.clear();
    //   for (var classRoomDoc in classRoomSnapshot.docs) {
    //     var classRoom = classRoomDoc.data();
    //     var classRoomModel = ClassroomModel.fromJson(classRoom);

    //     classRooms.add(classRoomModel);
    //   }
    //   yield classRooms;
    // }
    return classRooms;
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
