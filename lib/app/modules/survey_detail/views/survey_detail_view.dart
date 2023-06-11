import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../common/constant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/survey_detail_controller.dart';
import '../../../data/models/survey_detail.dart';

class SurveyDetailView extends GetView<SurveyDetailController> {
  const SurveyDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khảo sát số: #${controller.idSurveyNum}'),
        backgroundColor: const Color.fromARGB(255, 87, 241, 107),
        centerTitle: true,
      ),
      body: Column(
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
                      color: const Color.fromARGB(255, 80, 236, 100),
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
        const SizedBox(height: 2),
        ],
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
          onTap: () {
            //  Get.toNamed(Routes.SURVEY_DETAIL);
            // Fluttertoast.showToast(
            //   msg: '${surVeydetail.answers}',
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.BOTTOM,
            // );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                                fontSize: 17, color: Color.fromARGB(167, 0, 0, 0), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.card_membership_rounded,
                          color: primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        "Chọn tối đa: ${surVeydetail.type}",
                        style: const TextStyle(
                                fontSize: 17, color: Color.fromARGB(167, 0, 0, 0), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: surVeydetail.answers!.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Color.fromARGB(255, 42, 213, 168), // Màu sắc của line kẻ ngang
                        thickness: 2.0, // Độ dày của line kẻ ngang
                      ),
                      itemBuilder: (context, index) {
                        return Obx(() => CheckboxListTile( 
                            title: Text(" ${index+1} . ${surVeydetail.answers![index]["answer"]} "), 
                            value: surVeydetail.answers![index]["isCheck"].value,
                            onChanged: (value) {
                              surVeydetail.answers![index]["isCheck"].value = !surVeydetail.answers![index]["isCheck"].value;
                              if (value == true) {
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
                          ),
                        ); 
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
