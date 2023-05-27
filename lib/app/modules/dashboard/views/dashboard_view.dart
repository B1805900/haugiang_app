import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../../../common/widgets/background.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../data/models/survey.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

import 'constants.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          key: controller.scaffoldKey,
          drawer: buildDrawer(context),
          appBar: const CustomAppBar(
            title: 'Danh sách khảo sát',
          ),
          body: Stack(
            children: [
              Background(height: Get.size.height),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: buildSurveyList(context),
              ),
            ],
          ),
        ),
      );
    }
  Widget buildSurveyList(BuildContext context) {
    List<SurveyModel> surVey = controller.getSurveyList();
    if (surVey.isEmpty){
      return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: buildNullList(context),
    );
    }
      return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        children: surVey.map((SurveyModel surVey) {
        return InkWell(
          onTap: () {
              Get.toNamed(Routes.SURVEY_DETAIL, arguments: surVey.idSurvey);
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
                            "Tên khảo sát: ${surVey.nameSurvey}",
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
                        "Thời gian kết thúc: ${surVey.timeEnd}",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList()),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Drawer(
          child: Material(
            child: ListView(
              children: <Widget>[
                buildMenuItem(
                    text: 'Thoát',
                    icon: Icons.logout,
                    iconColor: Colors.black,
                    onPressed: () {
                      // SystemNavigator.pop();
                      Get.back();
                      Get.back();
                    }),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
    required GestureTapCallback onPressed,
  }) {
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: largeTextStyle,
      ),
      hoverColor: hoverColor,
      onTap: onPressed,
    );
  }

  Widget buildNullList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 107, 104),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: const Text('Hiện chưa có khảo sát!',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
