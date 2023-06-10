import 'package:get/get.dart';
import '../../../data/models/survey_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ApidemoController extends GetxController {
  final RxList<Map<String, dynamic>> selectedAnswers = <Map<String, dynamic>>[].obs;
  var propertyList = <Map<String, dynamic>>[].obs;
  List<SurveydetailModel> surveyList = [];

Future<List<SurveydetailModel>?> fetchData() async {
  var url = Uri.parse('http://api.ctu-it.com/API/surveydetail.php');
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
      // ignore: avoid_print
      print('Lỗi khi gọi API: ${response.statusCode}');
    }
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi khi gọi API: $e');
    }

    // Trả về null hoặc giá trị khác để biểu thị lỗi
    return null;
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
