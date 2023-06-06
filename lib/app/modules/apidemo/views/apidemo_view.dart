// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apidemo_controller.dart';

class ApidemoView extends GetView<ApidemoController> {
  const ApidemoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApidemoController>(
      init: ApidemoController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Danh sách câu hỏi'),
          ),
          body: ListView.builder(
            itemCount: controller.questions.length,
            itemBuilder: (context, index) {
              final question = controller.questions[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question.question),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: question.answers.length,
                    itemBuilder: (context, ansIndex) {
                      final answer = question.answers[ansIndex];
                      return CheckboxListTile(
                        title: Text(answer),
                        value: question.isSelected,
                        onChanged: (value) {
                          controller.toggleSelection(index, ansIndex);
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () {
              // Xử lý khi người dùng nhấn nút Hoàn tất
              // Ví dụ: In ra các câu hỏi và câu trả lời đã chọn
              for (final question in controller.questions) {
                for (var i = 0; i < 2; i++) {
                  // ignore: duplicate_ignore
                  if (question.isSelected) {
                    print('Câu hỏi: ${question.question}');
                    print('Câu trả lời: ${question.answers[i]}');
                  }
                }
              }
            },
          ),
        );
      },
    );
  }
}
