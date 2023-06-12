import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/constant.dart';
import '../controllers/survey_detail_controller.dart';
import '../../../data/models/survey_detail.dart';
import '../../../common/constant.dart';
import 'package:marquee_widget/marquee_widget.dart';
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
            image: AssetImage('assets/images/background.jpg'), // Đường dẫn đến hình nền
            fit: BoxFit.cover, // Cách ảnh nền được hiển thị trong Container
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Widget>(
                future: buildAnswerList(context),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Nếu đang kết nối hoặc đang chờ dữ liệu, hiển thị tiêu đề hoặc tiến trình tải
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Nếu xảy ra lỗi, hiển thị thông báo lỗi
                    print(snapshot.error);
                    return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
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
                  child: CircularProgressIndicator(), // Hiển thị vòng xoay tròn ở giữa màn hình
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
                }
              ),
          const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  Future<Widget> buildAnswerList(BuildContext context) async {
    controller.resultList.clear();
    List<SurveydetailModel>? surVeydetail = await controller.fetchData();
      return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        children: surVeydetail!.map((final SurveydetailModel surVeydetail) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.1),
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
                            "Câu hỏi: ${surVeydetail.question}",
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                  ),
                  Container(
                      height: 2,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),
                  Row(
                    children: [
                      const Icon(Icons.card_membership_rounded,
                          color: primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        "Chọn tối đa: ${surVeydetail.type} đáp án",
                        style: const TextStyle(
                                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                      height: 2,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: surVeydetail.answers!.length,
                      itemBuilder: (context, index) {
                        return Obx(() => InkWell(
                          onTap: () {
                            surVeydetail.answers![index]["isCheck"].value = !surVeydetail.answers![index]["isCheck"].value;
                            if (surVeydetail.answers![index]["isCheck"].value) {
                              controller.addResult(
                                controller.cccdNum.toString(),
                                controller.idSurveyNum.toString(),
                                surVeydetail.idQuestion,
                                surVeydetail.answers![index]["answer"],
                              );
                            } else {
                              controller.resultList.removeWhere((result) => result.idQuestion == surVeydetail.idQuestion && result.answer == surVeydetail.answers![index]["answer"]);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: surVeydetail.answers![index]["isCheck"].value ? Colors.white : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: surVeydetail.answers![index]["isCheck"].value
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 16,
                                        )
                                      : null,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  " ${surVeydetail.answers![index]["answer"]} ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList()),
    );
  }
}
