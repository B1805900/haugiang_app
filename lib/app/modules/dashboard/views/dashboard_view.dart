import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../../../data/models/survey.dart';
import '../../../routes/app_pages.dart';
import '../../survey_detail/controllers/survey_detail_controller.dart';
import '../controllers/dashboard_controller.dart';

import 'constants.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'), // Đường dẫn đến ảnh nền
              fit: BoxFit.fill, // Cách ảnh nền được hiển thị trong Container
            ),
          ),
          child: AppBar(
            title: const Text('Danh sách khảo sát'),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder<Widget>(
        future: buildSurveyList(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }


  Future<Widget> buildSurveyList(BuildContext context) async {
  List<SurveyModel> surveyList = await controller.fetchData();
  if (surveyList.isEmpty) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      // ignore: use_build_context_synchronously
      child: buildNullList(context),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
        child: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'), // Đường dẫn đến ảnh nền
            fit: BoxFit.cover, // Cách ảnh nền được hiển thị trong Container
          ),
        ),
        child: ListView(
          children: surveyList.map((survey) {
            return InkWell(
              onTap: () {
                final SurveyDetailController myController = Get.put(SurveyDetailController());
                myController.idSurveyNum = survey.idSurvey;
                Get.toNamed(Routes.SURVEY_DETAIL);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Màu nền của Container
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: primaryColor, width: 5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.class_rounded, color: primaryColor),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(
                              "Tên khảo sát: ${survey.nameSurvey}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.card_membership_rounded, color: primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            "Thời gian kết thúc: ${survey.timeEnd}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            );
          }).toList(),
        ),
      ),
    );
  }
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
