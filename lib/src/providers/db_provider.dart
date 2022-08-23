import 'package:api_sqflite/src/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  final String tbName = 'todo2';

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) {
      print('db is exists');
      return _database!;
    }

    // If database don't exists, create one
    _database = await initDB();
    print('db is NOT exists');
    return _database!;
  }

  // Create the database and the Employee table
  initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'db_todo.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE $tbName('
          'id INTEGER PRIMARY KEY,'
          'userId INTEGER NOT NULL,'
          'title TEXT,'
          'completed INTEGER NOT NULL'
          ')');
    });
  }

// delete db
  Future<void> deleteDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db_todo.db');

// Delete the database
    await deleteDatabase(path);
  }

  // Insert employee on database
  createEmployee(Todo newItem) async {
    //await deleteAllEmployees();
    final db = await database;
    final res = await db.insert(tbName, newItem.toJson());
    print('insert $res');
    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM $tbName');
    return res;
  }

  Future<List<Todo>> getAllEmployees() async {
    print('START==HTA');
    await Future.delayed(const Duration(seconds: 1));
    final db = await database;
    //final res = await db.rawQuery("SELECT * FROM todo");
    final res = await db.query(tbName);
    print('res length:.: ${res.length}');
    return res.map((json) => Todo.fromJson(json)).toList();
    // print(res[3]);
    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromJson(c)).toList() : [];

    //print(list[3].completed);

    print('list count: ${list.length.toString()}');
    return list;
  }
}
