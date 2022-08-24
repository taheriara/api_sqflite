import 'package:api_sqflite/src/models/question_model.dart';
import 'package:api_sqflite/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class QuestionApiProvider {
  Future<List<QuestionModel?>> getAllQuestionApi() async {
    var url =
        "https://almiqat.com/api/faq/GetFAQsBetweenTwoID?firstFaqId=1&LastFAQId=120";
    Response response = await Dio().get(url);

    print('get all count API: ${(response.data['data'] as List).length}');

    return (response.data['data'] as List).map((question) {
      DBProvider.db.createQuestion(QuestionModel.fromJsonApi(question));
    }).toList();
  }
}
