import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SinginController extends GetxController {
  //TODO: Implement SinginController
    final formKey = GlobalKey<FormState>();
    final TextEditingController fullnameController = TextEditingController();
    final TextEditingController ccccController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController adressController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController genderController = TextEditingController();
    final TextEditingController nationController = TextEditingController();
    final TextEditingController educationController = TextEditingController();
    final TextEditingController numpeopleController = TextEditingController();
    final TextEditingController numfemaleController = TextEditingController();
    final TextEditingController jobController = TextEditingController();
    final TextEditingController incomeController = TextEditingController();

    var selectedOption = 'Nam'.obs;
    void changeOption(String option) {
      selectedOption.value = option;
    }

    String? fullname;
    String? cccd;
    String? phone;
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

  @override
  void onInit() {
    super.onInit();
    fullnameController.text = "";
    ccccController.text = "";
    phoneController.text = "";
    emailController.text = "";
    adressController.text = "";
    ageController.text = "";
    genderController.text = "";
    nationController.text = "";
    educationController.text = "";
    numpeopleController.text = "";
    numfemaleController.text = "";
    jobController.text = "";
    incomeController.text = "";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    fullnameController.clear();
    ccccController.clear();
    phoneController.clear();
    emailController.clear();
    adressController.clear();
    ageController.clear();
    genderController.clear();
    nationController.clear();
    educationController.clear();
    numpeopleController.clear();
    numfemaleController.clear();
    jobController.clear();
    incomeController.clear();
  }



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
