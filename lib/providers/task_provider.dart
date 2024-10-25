import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/task_service.dart';

/// A provider class that manages the tasks in the to-do list.
///
/// This class extends [ChangeNotifier] to enable state changes when working with provider.
/// The [notifyListeners] method is used to signal the state change to the [Provider] in [main].
class TaskProvider with ChangeNotifier {
  List<TaskModel> _task = [];

  /// Returns the list of tasks.
  List<TaskModel> get tasks => _task;

  /// Loads tasks asynchronously and updates the task list.
  void loadTasks() async {
    _task = await TaskService().taskscontents();
    notifyListeners();
  }

  /// Adds a new task to the task list.
  ///
  /// The [task] parameter is the task to be added.
  void addTask(TaskModel task) async {
    await TaskService().addTask(task);
    _task.add(task);
    notifyListeners();
    debugPrint('add task from provider');
  }

  /// Updates an existing task in the task list.
  ///
  /// The [task] parameter is the updated task.
  void updateTask(TaskModel task) async {
    await TaskService().updateTask(task);
    int index = _task.indexWhere((t) => t.name == task.name);
    if (index != -1) {
      _task[index] = task;
      notifyListeners();
      debugPrint('update task from provider');
    }
  }

  /// Deletes a task from the task list.
  ///
  /// The [name] parameter is the name of the task to be deleted.
  void deleteTasks(String name) async {
    await TaskService().deleteTask(name);
    _task.removeWhere((task) => task.name == name);
    notifyListeners();
    debugPrint('delete task from provider');
  }

  /// Toggles the completion status of a task in the task list.
  ///
  /// The [name] parameter is the name of the task to be toggled.
  void toggleTaskCompletion(String name) async {
    int index = _task.indexWhere((task) => task.name == name);
    if (index != -1) {
      TaskModel taskModel = _task[index];
      taskModel = TaskModel(
        name: taskModel.name,
        isCompleted: !taskModel.isCompleted,
      );
      updateTask(taskModel);
    }
  }
}
