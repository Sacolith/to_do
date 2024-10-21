import 'package:to_do/models/task.dart';

/// A class that represents the task data.
class TaskService {
  
  ///Singleton Pattern Implementation for [TaskService]
  ///Ensures only 1 [TaskService] is referenced
  static final TaskService _instance= TaskService._internal();
   factory TaskService()=> _instance;
   TaskService._internal();
  
  final List<TaskModel> _tasks = [
    TaskModel(name: 'Buy milk'),
    TaskModel(name: 'Buy eggs'),
    TaskModel(name: 'Buy bread'),
  ];

  /// Getter for the list of tasks.
  List<TaskModel> get tasks => _tasks;

  /// Getter for the number of tasks.
  int get taskCount => _tasks.length;

  /// Adds a new task with the given [newTaskTitle].
  ///
  /// The [newTaskTitle] parameter specifies the title of the new task.
  void addTask(String newTaskTitle) {
    _tasks.add(TaskModel(name: newTaskTitle));
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
    _tasks.remove(task);
  }
}
