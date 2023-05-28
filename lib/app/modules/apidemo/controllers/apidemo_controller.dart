import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApidemoController extends GetxController {
  //TODO: Implement ApidemoController
    // Khởi tạo một biến observable để lưu trữ dữ liệu từ API
  var property1 = ''.obs;
  var property2 = ''.obs;

  void fetchData() async {
    var url = Uri.parse('http://bot.ctu-it.com/survey.php?id=Phan%20B%E1%BA%A3o%20Nh%C3%A2n&users=12345');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData is Map<String, dynamic>) {
          property1.value = jsonData['property1'];
          property2.value = jsonData['property2'];
        } else {
          print('Dữ liệu trả về không phải là một đối tượng Map');
        }
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
    }
  }


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
