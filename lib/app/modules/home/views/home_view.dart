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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center( // Thêm Center widget để căn giữa nội dung
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topCenter,
              ),
              const Text(
                'Chào mừng đến với ứng dụng \n\n khảo sát ý kiến người dân!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 247, 240, 240),
                  fontSize: 19,
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
      ),
    );
  }

}
