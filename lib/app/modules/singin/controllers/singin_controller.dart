import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SinginController extends GetxController {
  //TODO: Implement SinginController
    final formKey = GlobalKey<FormState>();
    var selectedOption = 'Nam'.obs;

    void changeOption(String option) {
      selectedOption.value = option;
    }

    String? fullname;
    int? cccd;
    int? phone;
    String? email;
    String? address;
    int? age;
    String? gender;
    String? nation;
    String? education;
    int? numpeople;
    int? numfemale;
    String? job;
    int? income;
    String? usedservice;

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

  Future<void> handleSignIn(BuildContext context) async {
    // ignore: avoid_print
    print('Login Button!');
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(cccd as String),
        duration: const Duration(seconds: 2),
      ),
    );

  showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Thông báo'),
      content: Text(email!),
      actions: [
        TextButton(
          child: const Text('Đóng'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    },
  );
  }
}
