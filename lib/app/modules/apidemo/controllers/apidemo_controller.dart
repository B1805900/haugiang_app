import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Question {
  String questionText;
  List<String> answers;
  int nextQuestionIndex;

  Question({required this.questionText, required this.answers, required this.nextQuestionIndex});
}

List<Question> questions = [
  Question(
    questionText: "Câu hỏi 1",
    answers: ["Trả lời 1", "Trả lời 2"],
    nextQuestionIndex: 1,
  ),
  Question(
    questionText: "Câu hỏi 2",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 2,
  ),
    Question(
    questionText: "Câu hỏi 3",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 3,
  ),
    Question(
    questionText: "Câu hỏi 4",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 4,
  ),
    Question(
    questionText: "Câu hỏi 5",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 5,
  ),
    Question(
    questionText: "Câu hỏi 6",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 6,
  ),
    Question(
    questionText: "Câu hỏi 7",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 7,
  ),
    Question(
    questionText: "Câu hỏi 8",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 8,
  ),
    Question(
    questionText: "Câu hỏi 9",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 9,
  ),
    Question(
    questionText: "Câu hỏi 10",
    answers: ["Trả lời 3", "Trả lời 4"],
    nextQuestionIndex: 10,
  ),
  // Thêm các câu hỏi khác...
];


class ApidemoController extends GetxController {
  List<Map<String, String>> questionsAndAnswers = [
    {
      'question': 'Question 1',
      'answer': 'Answer 1',
    },
    {
      'question': 'Question 2',
      'answer': 'Answer 2',
    },
    // Thêm các câu hỏi và câu trả lời khác vào đây
  ];
  
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
