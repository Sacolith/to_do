import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task.dart';

/// A class that represents the task data.
class TaskService {
  
  ///Singleton Pattern Implementation for [TaskService]
  ///Ensures only 1 [TaskService] is referenced
  static final TaskService _instance= TaskService._internal();
   factory TaskService()=> _instance;
   TaskService._internal();
  
///Creates a local sqflite database
  static Database? _database;

///Database getter
  Future<Database> get database async{
    if(_database !=null) return _database!;
    _database= await _initDatabase();
    return _database!;
  }

///Database initialization
  Future<Database> _initDatabase() async{
  String path= join(await getDatabasesPath(), 'task.db');
  return await openDatabase(
    path,
    onCreate: (db,version){
      return db.execute(
        'Create Table tasks(name TEXT PRIMARY KEY,isComplete INTEGER )'
        );
    },
    version: 1,
    );
  }
  // final List<TaskModel> _tasks = [
  //   TaskModel(name: 'Buy milk'),
  //   TaskModel(name: 'Buy eggs'),
  //   TaskModel(name: 'Buy bread'),
  // ];

  /// Getter for the list of tasks.
  //List<TaskModel> get tasks => _tasks;

  /// Getter for the number of tasks.
  //int get taskCount => _tasks.length;

  /// Adds a new task with the given [newTaskTitle].
  ///
  
  
  /// Creates new [task] using the [TaskModel] as data structure.
  /// When adding a new item to [Database] we use .insert
  /// since 'task' is the name of the table we make reference to it when using .insert
  /// local task model [task] insertes our new value into the [map] to ensure values a placed where they need to be
  /// [conflictAlgorithm] for duplicate values
  Future <void> addTask(TaskModel task) async{
    final db=await database;
    await db.insert('task', task.tasks(), conflictAlgorithm: ConflictAlgorithm.replace);
    //_tasks.add(TaskModel(name: newTaskTitle));
  }

  /// Updates the given [task] by toggling its completed status.
  ///
  /// The [task] parameter specifies the task to be updated.
  void updateTask(TaskModel task) {
    task.toggleCompleted();
  }

  /// Deletes the given [task].
  ///
  /// The [task] parameter specifies the task to be deleted.
  void deleteTask(TaskModel task) {
    //_tasks.remove(task);
  }
}
