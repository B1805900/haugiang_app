import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haugiang_app/app/common/constant.dart';
import '../../../data/models/survey_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/models/result.dart';


class SurveyDetailController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var cccdNum;
  var idSurveyNum;
  //TODO: Implement SurveyDetailController
  final List<ResultModel> resultList = <ResultModel>[];
  void addResult(String? cccd, String? idSurvey, String? idQuestion, String? answer) {
      resultList.add(ResultModel(
        cccd: cccd,
        idSurvey: idSurvey,
        idQuestion: idQuestion,
        answer: answer,
      ));
  }
      var isLoading = false.obs;

  Future<void> saveResult(List<ResultModel> resultList) async {
    isLoading.value = true;

    // Thực hiện công việc lưu người dùng
    await sendDataToAPI(resultList);

    isLoading.value = false;
  }

  Future<List<SurveydetailModel>?> fetchData() async {
    var url = Uri.parse('http://api.ctu-it.com/API/surveydetail.php?id_survey=$idSurveyNum');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonDataList = json.decode(jsonString) as List<dynamic>;
        var fetchedSurveyList = <SurveydetailModel>[];
        for (var jsonData in jsonDataList) {
          var idQuestion = jsonData['id_question'] as String;
          var question = jsonData['question'] as String;
          var answers = (jsonData['answers'] as List<dynamic>).cast<String>();
          var type = jsonData['type'] as int;

          fetchedSurveyList.add(
            SurveydetailModel(
              question,
              answers
                  .map(
                    (answer) => {'answer': answer, 'isCheck': false.obs},
                  )
                  .toList(),
              type,
              idQuestion,
            ),
          );
        }
        return fetchedSurveyList;
      } else {
        print('Lỗi khi gọi API: ${response.statusCode}');
      }
      } catch (e) {
        print('Lỗi khi gọi API: $e');
      }

      // Trả về null hoặc giá trị khác để biểu thị lỗi
      return null;
  }

  Future<void> sendDataToAPI(List<ResultModel> resultList) async {
  // Tạo danh sách các đối tượng ResultModel thành danh sách Map
  List<Map<String, dynamic>> resultsData = resultList.map((result) => result.toJson()).toList();
  
  // Tạo request body từ danh sách Map
  Map<String, dynamic> requestBody = {'results': resultsData};
  
  // Chuyển đổi request body thành chuỗi JSON
  String requestBodyJson = json.encode(requestBody);
  
  // Tạo request POST
  var response = await http.post(
    Uri.parse('http://api.ctu-it.com/API/saveResult.php'),
    headers: {'Content-Type': 'application/json'},
    body: requestBodyJson,
  );
      if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
      var responseData = jsonDecode(response.body);
        var status = responseData[0]['status'];
          if (status == 'success') {
          // Xử lý thành công
            // print('Luu CSLD Thành công');
            // Get.snackbar(
            //   'Lưu kết quả thành công', // Tiêu đề thông báo
            //   'Xin cảm ơn!', // Nội dung thông báo
            //   backgroundColor: Colors.green,
            //   colorText: Colors.white,
            //   snackPosition: SnackPosition.BOTTOM,
            //   duration: Duration(seconds: 2),
            // );
            showDialogMessage('Lưu kết quả thành công');
            // await Future.delayed(const Duration(seconds: 4));
            // // Chuyển về trang trước đó
            // Get.back();
          } else {
            // Xử lý lỗi
            // print(responseData[0]);
            // Get.snackbar(
            //   'Lỗi lưu dữ liệu', // Tiêu đề thông báo
            //   'Vui lòng thử lại', // Nội dung thông báo
            //   backgroundColor: Colors.red,
            //   colorText: Colors.white,
            //   snackPosition: SnackPosition.BOTTOM,
            //   duration: Duration(seconds: 2),
            // );
            showDialogMessage('Lưu kết quả không thành công');
          }
      } else {
        // Xử lý lỗi: phản hồi rỗng
        print('Empty response');
      }
    } else {
      // Xử lý lỗi: mã trạng thái không phải 200
      showDialogMessage('Không thể lưu kết quả do Lỗi kết nối!');
    }
  
  // // Kiểm tra response từ server
  // if (response.statusCode == 200) {
  //   // Xử lý response thành công
  //   print('Data sent successfully');
  //     Get.snackbar(
  //     'Success', // Tiêu đề thông báo
  //     'Data sent successfully', // Nội dung thông báo
  //     backgroundColor: Colors.green,
  //     colorText: Colors.white,
  //     snackPosition: SnackPosition.BOTTOM,
  //     duration: Duration(seconds: 2),
  //   );
  //   await Future.delayed(const Duration(seconds: 4));
  //   // Chuyển về trang trước đó
  //   Get.back();
  // } else {
  //   // Xử lý response lỗi
  //   print('Error sending data');
  //   Get.snackbar(
  //       'Error', // Tiêu đề thông báo
  //       'Error sending data', // Nội dung thông báo
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: Duration(seconds: 2),
  //     );
  // }
}



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

  void showDialogMessage(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(result: 'Đóng');
            },
            child: const Text('Đóng', style: TextStyle(color: primaryColor, fontSize: 18),),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
