import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/task_service.dart';

/// A provider class that manages the tasks in the to-do list.
///
/// This class extends [ChangeNotifier] to enable state changes when working with provider.
/// The [notifyListeners] method is used to signal the state change to the [Provider] in [main].
class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<TaskModel> _tasks = [];

  /// Returns the list of tasks.
  List<TaskModel> get tasks => _tasks;

  /// Returns the count of tasks.
  int get taskCount => _tasks.length;

  /// Loads tasks asynchronously and updates the task list.
  Future<void> loadTasks() async {
    _tasks = await _taskService.taskscontents();
    notifyListeners();
  }

  /// Adds a new task to the task list.
  ///
  /// The [task] parameter is the task to be added.
  Future<void> addTask(TaskModel task) async {
    await _taskService.addTask(task);
    _tasks.add(task);
    notifyListeners();
    debugPrint('add task from provider');
  }

  /// Updates an existing task in the task list.
  ///
  /// The [task] parameter is the updated task.
  Future<void> updateTask(TaskModel task) async {
    int index = _tasks.indexWhere((t) => t.name == task.name);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
      debugPrint('${task.name} updated${task.isCompleted}');
      await _taskService.updateTask(task);
    }
  }

  /// Deletes a task from the task list.
  ///
  /// The [name] parameter is the name of the task to be deleted.
  Future<void> deleteTasks(String name) async {
    _tasks.removeWhere((task) => task.name == name);
    notifyListeners();
    await _taskService.deleteTask(name);
  }

  /// Edits an existing task in the task list.
  ///
  /// The [updatedTask] parameter is the updated task.
  Future<void> editTask(TaskModel updatedTask) async {
    debugPrint('Attempting to edit task: ${updatedTask.name}');
    debugPrint('Current tasks: ${_tasks.map((task) => task.name).toList()}');

    int index = _tasks.indexWhere((task) =>
        task.name.trim().toLowerCase() == task.name.trim().toLowerCase());

    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
      await _taskService.updateTask(updatedTask);
      debugPrint('Task updated: ${updatedTask.name}');
    } else {
      debugPrint('Task not found: ${updatedTask.name}');
    }
  }
}
