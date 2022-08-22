import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  int id;
  int userId;
  String title;
  bool completed;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": userId,
        "firstName": title,
        "lastName": completed,
      };
}
