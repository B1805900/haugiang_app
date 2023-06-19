import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/constant.dart';
import '../controllers/survey_detail_controller.dart';
import '../../../data/models/survey_detail.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
  PageController pageController = PageController();
  //ScrollController scrollController = ScrollController();
  AutoScrollController scrollController = AutoScrollController();
    controller.resultList.clear();
    controller.listKeyofpage.clear();
    controller.sttPadding.clear();
    final List<SurveydetailModel>? surVeydetail = await controller.fetchData();
    if (surVeydetail != null) {
    for (int i=0; i<surVeydetail.length; i++) {
      final SurveydetailModel survey = surVeydetail[i];
          for(int j=0; j<survey.questions!.length; j++){
            final QuestionModel question =  survey.questions![j];
            controller.listKeyofpage[ValueKey(question.idQuestion)] = i;
            controller.sttPadding[ValueKey(question.idQuestion)] = j;
            for(int k=0; k<question.answers!.length; k++){
            //  controller.sttPadding[ValueKey(question.idQuestion)] = k;
              // final AnswerModel answer = question.answers![k];
              // print(answer.moveto);
            }
          }
    }
      return Stack(children: [
        PageView.builder(
          controller: pageController,
          itemCount: surVeydetail.length,
          itemBuilder: (context, groupIndex) {
            final SurveydetailModel survey = surVeydetail[groupIndex];
            double screenWidth = MediaQuery.of(context).size.width;
            double itemWidth = screenWidth / (surVeydetail.length + 1);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    surVeydetail.length,
                    (index) => GestureDetector(
                      onTap: () {
                        // Di chuyển đến page tương ứng khi người dùng nhấp vào
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: itemWidth, // Định nghĩa chiều rộng của thanh ngang
                        height: 10, // Định nghĩa chiều cao của thanh ngang
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5), // Khoảng cách giữa các thanh ngang
                        color: groupIndex == index
                            ? primaryColor
                            : Colors
                                .grey, // Màu sắc tùy thuộc vào trạng thái của page
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    "Nhóm câu hỏi: ${survey.groupName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: survey.questions!.length,
                    itemBuilder: (context, questionIndex) {
                      final QuestionModel question =
                          survey.questions![questionIndex];
                     return Padding(
                        key: ValueKey(question.idQuestion),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: primaryColor, width: 3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.class_rounded,
                                          color: secondaryColor),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: Get.width * 0.7,
                                        child: Text(
                                          "Câu hỏi ${questionIndex + 1}: ${question.question}",
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            height: 1.5,
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
                                          color: secondaryColor),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Chọn tối đa: ${question.type} đáp án",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
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
                                      physics:const NeverScrollableScrollPhysics(),
                                      itemCount: question.answers!.length,
                                      itemBuilder: (context, index) {
                                      //  controller.countAnswer = 0;
                                      controller.answerCounts[question.idQuestion] = 0;
                                        return GetBuilder<
                                            SurveyDetailController>(
                                          init: SurveyDetailController(),
                                          builder: (controller) {
                                            final AnswerModel answer =
                                                question.answers![index];
                                            return InkWell(
                                              onTap: () {
                                                if (controller.answerCounts[question.idQuestion]! <
                                                    question.type) {
                                                  answer.isCheck =
                                                      !(answer.isCheck ??
                                                          false);
                                                  if ((answer.isCheck ??
                                                      false)) {
                                                    controller.answerCounts[question.idQuestion] = controller.answerCounts[question.idQuestion]! + 1;
                                                    controller.addResult(
                                                      controller.cccdNum
                                                          .toString(),
                                                      controller.idSurveyNum
                                                          .toString(),
                                                      question.idQuestion,
                                                      answer.answer,
                                                    );
                                                  } else {
                                                    controller.answerCounts[question.idQuestion] = controller.answerCounts[question.idQuestion]! - 1;
                                                    controller.resultList
                                                        .removeWhere((result) =>
                                                            result.idQuestion ==
                                                                question
                                                                    .idQuestion &&
                                                            result.answer ==
                                                                answer.answer);
                                                  }
                                                  controller.update();
                                                } else {
                                                  if ((answer.isCheck ?? true)) {
                                                    controller.answerCounts[question.idQuestion] = controller.answerCounts[question.idQuestion]! - 1;
                                                    answer.isCheck =
                                                      !(answer.isCheck ??
                                                          true);
                                                    controller.resultList
                                                        .removeWhere((result) =>
                                                            result.idQuestion ==
                                                                question
                                                                    .idQuestion &&
                                                            result.answer ==
                                                                answer.answer);
                                                    controller.update();
                                                  }else{
                                                    controller.showDialogMessagenew("Vượt quá số lượng đáp án!");
                                                  }
                                                }
                                                if(answer.isCheck == true){
                                                  int? newPageIndex = controller.listKeyofpage[ValueKey("${answer.moveto}")];
                                               // int? newPageIndex = 1;
                                               if(newPageIndex == null){
                                                  print("Câu hỏi liên kết không nằm cùng khảo sats");
                                                } else if (newPageIndex != groupIndex) {
                                                    Future.delayed(const Duration(milliseconds: 500), () {
                                                      pageController.jumpToPage(newPageIndex);
                                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                                        scrollController.animateTo(
                                                          scrollController.position.maxScrollExtent,  // Vị trí cuối cùng của SingleChildScrollView
                                                          duration: const Duration(milliseconds: 500),  // Thời gian cuộn
                                                          curve: Curves.ease,  // Hiệu ứng cuộn
                                                        );
                                                      //  controller.showDialogMessagenew("Cuộn thành công!");
                                                      });
                                                    });
                                                  } else  {
                                                    Future.delayed(const Duration(milliseconds: 500), () {
                                                      pageController.jumpToPage(newPageIndex);
                                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                                        scrollController.animateTo(
                                                          scrollController.position.maxScrollExtent,  // Vị trí cuối cùng của SingleChildScrollView
                                                          duration: const Duration(milliseconds: 500),  // Thời gian cuộn
                                                          curve: Curves.ease,  // Hiệu ứng cuộn
                                                        );
                                                      //  controller.showDialogMessagenew("Cuộn thành công!");
                                                      });
                                                    });
                                                  }
                                                }
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
                                                        color: (answer
                                                                    .isCheck ??
                                                                false)
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: (answer.isCheck ??
                                                              false)
                                                          ? const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.black,
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
        ),
      ]);
    } else {
      // Trả về một widget để biểu thị khi không có dữ liệu hoặc xảy ra lỗi
      return const Text('No data available');
    }
  }
}

