import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/users.dart';

class SinginController extends GetxController {
  //TODO: Implement SinginController
    final formKey = GlobalKey<FormState>();
    // final TextEditingController fullnameController = TextEditingController();
    // final TextEditingController ccccController = TextEditingController();
    // final TextEditingController phoneController = TextEditingController();
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController adressController = TextEditingController();
    // final TextEditingController ageController = TextEditingController();
    // final TextEditingController genderController = TextEditingController();
    // final TextEditingController nationController = TextEditingController();
    // final TextEditingController educationController = TextEditingController();
    // final TextEditingController numpeopleController = TextEditingController();
    // final TextEditingController numfemaleController = TextEditingController();
    // final TextEditingController jobController = TextEditingController();
    // final TextEditingController incomeController = TextEditingController();

    final List<String> genderOptions = ["Nam", "Nữ", "Khác"];
    final RxString selectedGender = "Nam".obs;

    UsersModel userInfo = UsersModel();

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



  Future<void> handleSignIn(BuildContext context) async {
    // ignore: avoid_print
    print('Login Button!');
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(userInfo.cccd as String),
        duration: const Duration(seconds: 2),
      ),
    );

  showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Thông báo'),
      content: Text(userInfo.email!),
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
