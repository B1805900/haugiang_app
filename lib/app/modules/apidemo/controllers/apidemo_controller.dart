import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ApidemoController extends GetxController {
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
