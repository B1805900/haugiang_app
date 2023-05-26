import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/qrscaner_controller.dart';

class QrscanerView extends GetView<QrscanerController> {
  const QrscanerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QrscanerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QrscanerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
