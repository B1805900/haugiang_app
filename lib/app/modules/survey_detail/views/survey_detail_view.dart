import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/constant.dart';
import '../controllers/survey_detail_controller.dart';
import '../../../data/models/survey_detail.dart';

class SurveyDetailView extends GetView<SurveyDetailController> {
  const SurveyDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.nameSurveytitle),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Widget>(
                future: buildAnswerList(context),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Nếu đang kết nối hoặc đang chờ dữ liệu, hiển thị tiêu đề hoặc tiến trình tải
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Nếu xảy ra lỗi, hiển thị thông báo lỗi
                    print(snapshot.error);
                    return Center(
                        child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
                  } else {
                    // Nếu có dữ liệu, hiển thị danh sách khảo sát
                    return snapshot.data!;
                  }
                },
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child:
                      CircularProgressIndicator(), // Hiển thị vòng xoay tròn ở giữa màn hình
                );
              } else {
                return InkWell(
                  onTap: () {
                    controller.saveResult(controller.resultList);
                  },
                  child: Container(
                    //   width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primaryColor,
                    ),
                    child: const Text(
                      'Lưu kết quả',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            }),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  Future<Widget> buildAnswerList(BuildContext context) async {
    controller.resultList.clear();
    final List<SurveydetailModel>? surVeydetail = await controller.fetchData();
    PageController pageController = PageController();
    if (surVeydetail != null) {
      return PageView.builder(
        controller: pageController,
        itemCount: surVeydetail.length,
        itemBuilder: (context, groupIndex) {
          final SurveydetailModel survey = surVeydetail[groupIndex];
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "Nhóm câu hỏi: ${survey.groupName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 235, 205, 205),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: survey.questions!.length,
                  itemBuilder: (context, questionIndex) {
                    final QuestionModel question =
                        survey.questions![questionIndex];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: primaryColor, width: 3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.class_rounded,
                                        color: primaryColor),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: Get.width * 0.7,
                                      child: Text(
                                        "Câu hỏi ${questionIndex + 1}: ${question.question}",
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.card_membership_rounded,
                                        color: primaryColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Chọn tối đa: ${question.type} đáp án",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                ),
                                const SizedBox(height: 5),
                                SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: question.answers!.length,
                                    itemBuilder: (context, index) {
                                      return GetBuilder<SurveyDetailController>(
                                        init: SurveyDetailController(),
                                        builder: (controller) {
                                          final AnswerModel answer =
                                              question.answers![index];
                                          return InkWell(
                                            onTap: () {
                                              answer.isCheck =
                                                  !(answer.isCheck ?? false);
                                              if ((answer.isCheck ?? false)) {
                                                controller.addResult(
                                                  controller.cccdNum.toString(),
                                                  controller.idSurveyNum
                                                      .toString(),
                                                  question.idQuestion,
                                                  answer.answer,
                                                );
                                              } else {
                                                controller.resultList
                                                    .removeWhere((result) =>
                                                        result.idQuestion ==
                                                            question
                                                                .idQuestion &&
                                                        result.answer ==
                                                            answer.answer);
                                              }
                                              controller.update();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (answer.isCheck ??
                                                              false)
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: (answer.isCheck ??
                                                            false)
                                                        ? const Icon(
                                                            Icons.check,
                                                            color: Colors.black,
                                                            size: 16,
                                                          )
                                                        : null,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    " ${answer.answer} ",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      // Trả về một widget để biểu thị khi không có dữ liệu hoặc xảy ra lỗi
      return const Text('No data available');
    }
  }
}
