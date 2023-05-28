import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/apidemo_controller.dart';

class ApidemoView extends GetView<ApidemoController> {
  const ApidemoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dữ liệu từ API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Property 1: ${controller.property1.value}')),
            Obx(() => Text('Property 2: ${controller.property2.value}')),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Gọi hàm fetchData() để lấy dữ liệu từ API
          controller.fetchData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
