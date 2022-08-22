import 'package:api_sqflite/src/models/todo_model.dart';
import 'package:api_sqflite/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class TodoApiProvider {
  Future<List<Todo?>> getAllEmployees() async {
    var url = "https://jsonplaceholder.typicode.com/todos";
    Response response = await Dio().get(url);

    return (response.data as List).map((employee) {
      DBProvider.db.createEmployee(Todo.fromJson(employee));
    }).toList();
  }
}

//https://stackoverflow.com/questions/59434571/how-to-store-api-json-data-into-sqflite-in-flutter
//using: 
// return employeeFromJson(response.data).map((employee) {
//   print('Inserting $employee');
//   DBProvider.db.createEmployee(employee);
// }).toList();

// instead of

// return (response.data as List).map((employee) {
//   print('Inserting $employee');
//   DBProvider.db.createEmployee(Employee.fromJson(employee));
// }).toList();
