import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ApidemoController extends GetxController {
  List<Map<String, String>> questionsAndAnswers = [
    {
      'question': 'Question 1',
      'answer': 'Answer 1',
    },
    {
      'question': 'Question 2',
      'answer': 'Answer 2',
    },
    // Thêm các câu hỏi và câu trả lời khác vào đây
  ];
  
  void showMyDialog(String mess) {
      Get.dialog(
        AlertDialog(
          title: const Text('Thông báo'),
          content: Text(mess),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back(result: 'Đóng');
              },
              child: const Text('Đóng'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
  }
}
