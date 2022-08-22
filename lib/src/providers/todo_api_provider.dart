import 'package:api_sqflite/src/models/todo_model.dart';
import 'package:api_sqflite/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class TodoApiProvider {
  Future<List<Todo?>> getAllEmployees() async {
    var url = "https://jsonplaceholder.typicode.com/todos";
    Response response = await Dio().get(url);

    print('api ----: ${response.toString()}');

    return todoFromJson(response.data).map((employee) {
      print('Inserting $employee');
      //DBProvider.db.createEmployee(employee);
    }).toList();
  }
}
