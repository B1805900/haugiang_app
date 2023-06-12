import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apidemo_controller.dart';

class ApidemoView extends GetView<ApidemoController> {
  const ApidemoView({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(questions[index].questionText),
            subtitle: Column(
              children: List.generate(
                questions[index].answers.length,
                (answerIndex) => CheckboxListTile(
                  title: Text(questions[index].answers[answerIndex]),
                  value: false, // Giá trị của checkbox
                  onChanged: (newValue) {
                    // Xử lý khi người dùng thay đổi trạng thái checkbox
                    int nextQuestionIndex = questions[index].nextQuestionIndex;
                    // ignore: unnecessary_null_comparison
                    if (nextQuestionIndex != null) {
                      scrollController.jumpTo(
                        nextQuestionIndex * 1000, // itemHeight là chiều cao của mỗi item trong ListView
                      );
                      // Hoặc sử dụng animateTo để tạo hiệu ứng di chuyển mượt hơn:
                      // scrollController.animateTo(
                      //   nextQuestionIndex * itemHeight,
                      //   duration: Duration(milliseconds: 500),
                      //   curve: Curves.ease,
                      // );
                    } else {
                      // Xử lý khi không có câu hỏi tiếp theo
                    }
                  },
                ),
              ),
            ),
          );
        },
      )
    );
  }
}