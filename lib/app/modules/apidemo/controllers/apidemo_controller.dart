import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApidemoController extends GetxController {
  //TODO: Implement ApidemoController
  var propertyList = <Map<String, dynamic>>[].obs;

  void fetchData() async {
    var url = Uri.parse('http://api.ctu-it.com/survey.php');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonDataList = jsonString.split('}{');
        jsonDataList = jsonDataList.map((jsonString) {
          if (!jsonString.startsWith('{')) jsonString = '{' + jsonString;
          if (!jsonString.endsWith('}')) jsonString += '}';
          return jsonString;
        }).toList();

        var properties = <Map<String, dynamic>>[];
        for (var jsonData in jsonDataList) {
          var property = json.decode(jsonData);
          properties.add(property);
        }

        propertyList.value = properties;
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
