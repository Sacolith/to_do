import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task.dart';

/// A class that represents the task data.


class TaskService  {

  ///Singleton Pattern Implementation for [TaskService]
  ///Ensures only 1 [TaskService] is referenced
  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;
  TaskService._internal();

  ///Creates a local sqflite database
  static Database? _database;

  ///Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  ///Database initialization
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            'Create Table tasks(name TEXT PRIMARY KEY,isComplete INTEGER )');
      },
      version: 1,
    );

  }  


  /// Creates new [task] using the [TaskModel] as data structure.
  /// When adding a new item to [Database] we use .insert
  /// since 'task' is the name of the table we make reference to it when using .insert
  /// local task model [task] insertes our new value into the [map] to ensure values a placed where they need to be
  /// [conflictAlgorithm] for duplicate values

  Future<void> addTask(TaskModel task) async {
    final db = await database;
    await db.insert('tasks', task.tasks(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }

  ///Creates a list of Tasks [taskcontents] from [database]
  Future<List<TaskModel>> taskscontents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (int i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  /// Updates the given [task] using .updatetask [db] and it checkes [where] the [task.name].
  ///
  /// The [task] parameter specifies the task to be updated.
  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db
        .update('tasks', task.tasks(), where: "name=?", whereArgs: [task.name]);
    debugPrint('Task Updated successfully');

  }

  /// Deletes the given [task] with specific name.
  ///
  /// The [task] parameter specifies the task to be deleted.

  Future <void> deleteTask(String name) async{
    final db= await database;
    await db.delete('tasks',where: 'name=?',whereArgs: [name]);
   debugPrint('Task deleted successfully');
 
  }

}
