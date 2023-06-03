import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/apidemo_controller.dart';

class ApidemoView extends GetView<ApidemoController> {
  const ApidemoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dữ liệu từ API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () {
                if (controller.propertyList.isEmpty) {
                  return const Text('Không có dữ liệu');
                } else {
                  return Column(
                    children: controller.propertyList.map((property) {
                      return Column(
                        children: [
                          Text('Property 1: ${property['id_survey']}'),
                          Text('Property 2: ${property['name_survey']}'),
                          Text('Property 3: ${property['time_create']['date'].substring(0, 10)}'),
                          Text('Property 4: ${property['time_end']['date'].substring(0, 10)}'),
                          Text('Property 5: ${property['username']}'),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
