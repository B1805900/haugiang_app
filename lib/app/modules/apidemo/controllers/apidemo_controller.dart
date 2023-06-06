import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/question.dart';


class ApidemoController extends GetxController {
  //TODO: Implement ApidemoController

    final questions = <QuestionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions(); // Gọi hàm này để lấy dữ liệu từ API và cập nhật danh sách câu hỏi
  }

    void fetchQuestions() {
    // Lấy dữ liệu từ API và cập nhật danh sách câu hỏi
    // Trong ví dụ này, tôi giả định rằng bạn đã sử dụng package http để gọi API
    // Đảm bảo import package http và có sự kết nối mạng trong thiết bị của bạn
    // Sau đó, bạn có thể thay đổi phương thức này để phù hợp với API của bạn
    // Đây chỉ là một ví dụ đơn giản để giúp bạn hiểu cách làm việc

    const jsonString =
        '[{"id_question":"000001","question":"Mức độ công khai của chính quyền địa phương trong các chính sách hỗ trợ người dân, doanh nghiệp.","answers":"Rất không tốt;Không tốt;Bình thường;Tốt;Rất tốt","type":1},'
        '{"id_question":"000002","question":"Mức độ dễ dàng, thuận tiện trong việc tiếp cận các chính sách ưu đãi của chính quyền địa phương.","answers":"Rất không tốt;Không tốt;Bình thường;Tốt;Rất tốt","type":1}]';

    final List<dynamic> jsonList = jsonDecode(jsonString);

    questions.assignAll(jsonList.map((json) {
      final id = json['id_question'] as String;
      final question = json['question'] as String;
      final answers = (json['answers'] as String).split(';');
      return QuestionModel(id: id, question: question, answers: answers);
    }).toList());
  }

  void toggleSelection(int index, int ansIndex) {
    final question = questions[index];
    question.isSelected = !question.isSelected;
    questions[index] = question;
  }


  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
