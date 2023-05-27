import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import 'package:haugiang_app/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellcome'),
        centerTitle: true,
      ),
      
      // ignore: avoid_unnecessary_containers
      body: Container( // hoặc Expanded
        color: const Color.fromARGB(255, 216, 237, 237),
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const SizedBox(height: 20),
            // Các widget con khác
            const Text(
                'Chào mừng đến với ứng dụng \n khảo sát ý kiến người dân \n Tỉnh Hậu Giang!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 30, 101, 167),
                    fontSize: 19,
                  //  backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.2,
                  softWrap: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.SINGIN);
              },
              child: const Text(
                'Bắt đầu',
                    style: TextStyle(
                    color: Color.fromARGB(255, 189, 223, 89),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
