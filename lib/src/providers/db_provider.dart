import 'package:api_sqflite/src/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Employee table
  initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'db_todo.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE todo('
          'id INTEGER PRIMARY KEY,'
          'userId INTEGER NOT NULL,'
          'title TEXT,'
          'completed BOOLEAN NOT NULL'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(Todo newItem) async {
    print('insert-1');
    await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('todo', newItem.toJson());
    print('insert-2');
    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM todo');

    return res;
  }

  Future<List<Todo>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM todo");

    List<Todo> list =
        res.isNotEmpty ? res.map((c) => Todo.fromJson(c)).toList() : [];

    print('list count: ${list.length.toString()}');
    return list;
  }
}
