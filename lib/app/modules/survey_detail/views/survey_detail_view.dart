import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../common/constant.dart';
import '../../../common/widgets/background.dart';
import '../controllers/survey_detail_controller.dart';

import '../../../data/models/survey_detail.dart';

class SurveyDetailView extends GetView<SurveyDetailController> {
  const SurveyDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('$data'),
        centerTitle: true,
      ),
        body: Stack(
          children: [
            Background(height: Get.size.height),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: buildAnswerList(context),
            ),
          ],
        ),
    );
  }
  Widget buildAnswerList(BuildContext context) {
    List<SurveydetailModel> surVeydetail = controller.getServeydetail();
      return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: surVeydetail.map((SurveydetailModel surVeydetail) {
        return InkWell(
          onTap: () {
            //  Get.toNamed(Routes.SURVEY_DETAIL);
            Fluttertoast.showToast(
              msg: '${surVeydetail.answers}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.card_membership_rounded,
                          color: primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        "Chọn tối đa: ${surVeydetail.type}",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: surVeydetail.answers!.length,
                      itemBuilder: (context, index) {
                      return Obx(() => CheckboxListTile( 
                          title: Text(" ${index+1} . ${surVeydetail.answers![index]} "), 
                          value: controller.checkedStates[index], 
                          onChanged: (value) {
                            controller.toggleCheckbox(index);
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
