import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/singin_controller.dart';
import '../../../common/widgets/custom_textformfield.dart';

class SinginView extends GetView<SinginController> {
  const SinginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        centerTitle: true,
      ),
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
            const SizedBox(height: 5),
            _buildLoginForm(context),
          ],
        ),
      ),
    );
  }
    Form _buildLoginForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(46, 30, 46, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Họ tên...', icon: Icons.drive_file_rename_outline),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Họ tên không được rỗng";
                    } else if (!GetUtils.isNum(value)) {
                      return "Vui lòng nhập họ tên hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.fullname = "Phan Bảo Nhân";
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Số CCCD...', icon: Icons.recent_actors),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Số CCCD không được rỗng";
                    } else if (!GetUtils.isNum(value)) {
                      return "Vui lòng nhập số CCCD hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.cccd = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Số điện thoại...', icon: Icons.phone_android),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Số điện thoại không được rỗng";
                    } else if (!GetUtils.isNum(value)) {
                      return "Vui lòng nhập số điện thoại hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.phone = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Email...', icon: Icons.person),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email không được rỗng";
                    } else if (!GetUtils.isEmail(value)) {
                      return "Vui lòng nhập email hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.email = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Địa chỉ...', icon: Icons.location_city),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Địa chỉ không được rỗng';
                    } else if (value.length < 6) {
                      return 'Vui lòng nhập địa chỉ hợp lệ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.password = value!;
                  },
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () => Get.toNamed(Routes.DASHBOARD),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 189, 223, 89),
                    ),
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Get.toNamed(Routes.QRSCANER),
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.QRSCANER);
              },
              child: const Text('Tiếp tục bằng QR CCCD',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  )),
            ),
          ),
        ],
      ),
    );
  }  
}
