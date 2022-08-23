import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJsonApi(x)));

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

//for get from db and then show
  static Todo fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"] != 0 ? true : false,
      );

//for first time when get api and save to db then getAll to show.
  factory Todo.fromJsonApi(Map<String, dynamic> json) => Todo(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "completed": completed ? 1 : 0,
      };
}
