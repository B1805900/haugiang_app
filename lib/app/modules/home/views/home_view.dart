import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../controllers/home_controller.dart';

import 'package:haugiang_app/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      
      // ignore: avoid_unnecessary_containers
      body: Container( // hoặc Expanded
    //    color: const Color.fromARGB(255, 216, 237, 237),
    //    padding: const EdgeInsets.symmetric(vertical: 60.0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.jpg'), // Đường dẫn đến hình ảnh của bạn
                fit: BoxFit.cover, // Tuỳ chọn về cách hiển thị hình ảnh
              ),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
            ),
            const SizedBox(height: 330),
            const Text(
                'Chào mừng đến với ứng dụng \n\n khảo sát ý kiến người dân!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 247, 240, 240),
                    fontSize: 19,
                  //  backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.3,
                  softWrap: true,
            ),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                    Get.toNamed(Routes.SINGIN);
                },
              child: Container(
                 width: 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryColor,
                ),
                child: const Text(
                  'Bắt đầu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
