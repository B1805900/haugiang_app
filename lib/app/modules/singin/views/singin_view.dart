import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../survey_detail/controllers/survey_detail_controller.dart';
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
      body: Container(
        color: const Color.fromARGB(255, 216, 237, 237),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ...Các phần tử khác
                _buildLoginForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Form _buildLoginForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
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
                  controller: controller.fullnameController,
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Họ tên...', icon: Icons.drive_file_rename_outline),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Họ tên không được rỗng";
                    } else if (value.length <= 3) {
                      return "Vui lòng nhập họ tên hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.fullname = value ?? '';
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.ccccController,
                  keyboardType: TextInputType.number,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Số CCCD...', icon: Icons.recent_actors),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập số Căn cước công dân';
                    } else if (value.length != 12) {
                      return 'Số căn cước phải có đúng 12 số';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.cccd = value ?? '';
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
                    controller.phone = value ?? '';
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
                    controller.address = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Học vấn...', icon: Icons.school),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Học vấn không được rỗng";
                    } else if (value.length < 2) {
                      return "Vui lòng nhập học vấn hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.education = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Dân tộc...', icon: Icons.pix),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Dân tộc không được rỗng";
                    } else if (value.length < 3) {
                      return "Vui lòng nhập tên dân tộc hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.nation = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Nghề nghiệp...', icon: Icons.work),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nghề nghiệp không được rỗng";
                    } else if (value.length < 2) {
                      return "Vui lòng nhập nghề nghiệp hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.job = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Thu nhập...', icon: Icons.money),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Thu nhập không được rỗng";
                    } else if (!GetUtils.isNum(value)) {
                      return "Vui lòng nhập số thu nhập hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.income = int.tryParse(value ?? '');
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Giới tính:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              )),
                    const SizedBox(width: 20),
                    // ignore: sized_box_for_whitespace
                    Obx(() => Container(
                      width: 85, // Giới hạn chiều ngang của Container
                      child: DropdownButton<String>(
                        value: controller.selectedOption.value,
                        onChanged: (String? newValue) {
                          controller.changeOption(newValue!);
                        },
                        items: <String>['Nam', 'Nữ', 'Khác']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                    const SizedBox(width: 10),
                    const Text('Tuổi:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              )),
                    const SizedBox(width: 10),
                    Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: buildDecorationTextFormField(
                          hintText: '.'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Tuổi không được rỗng";
                            } else if (!GetUtils.isNum(value)) {
                              return "Vui lòng nhập số tuổi hợp lệ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.age = int.tryParse(value ?? '');
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Nhân khẩu:',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      )),
                    const SizedBox(width: 5),
                    Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: buildDecorationTextFormField(
                          hintText: '.'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Số nhân khẩu không được rỗng";
                            } else if (!GetUtils.isNum(value)) {
                              return "Vui lòng nhập số nhân khẩu hợp lệ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.numpeople = int.tryParse(value ?? '');
                          },
                        ),
                      ),
                    const SizedBox(width: 5),
                    const Text('Số nữ:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              )),
                    const SizedBox(width: 5),
                    Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: buildDecorationTextFormField(
                          hintText: '.'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Số thành viên nữ không được rỗng";
                            } else if (!GetUtils.isNum(value)) {
                              return "Vui lòng nhập số thành viên nữ hợp lệ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.numfemale = int.tryParse(value ?? '');
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),              
                InkWell(
                    onTap: () {
                      // Hàm xử lý sự kiện khi người dùng nhấn vào InkWell
                          if (controller.formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Processing Data')),
                        // );
                        controller.formKey.currentState!.save(); // Gọi hàm onSaved của TextFormField
                       // controller.cccd = controller.fullnameController.text as int?;
                        print(controller.cccd);
                        print(controller.fullname);
                        final SurveyDetailController myController = Get.put(SurveyDetailController());
                        myController.cccdNum = controller.cccd;
                        Get.toNamed(Routes.DASHBOARD);
                      }
                    },
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
          //const SizedBox(height: 10),
          // InkWell(
          //   onTap: () => Get.toNamed(Routes.QRSCANER),
          //   child: TextButton(
          //     onPressed: () {
          //       Get.toNamed(Routes.QRSCANER);
          //     },
          //     child: const Text('Tiếp tục bằng QR CCCD',
          //         style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.grey,
          //         )),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // InkWell(
          //   onTap: () => Get.toNamed(Routes.APIDEMO),
          //   child: TextButton(
          //     onPressed: () {
          //       Get.toNamed(Routes.APIDEMO);
          //     },
          //     child: const Text('Test API',
          //         style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.grey,
          //         )),
          //   ),
          // ),
        ],
      ),
      ),
    );
  }  
}
