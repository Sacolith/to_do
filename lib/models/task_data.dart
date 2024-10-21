import 'package:to_do/models/task.dart';

class TaskData {
  final List<TaskModel> _tasks = [
    TaskModel(name: 'Buy milk'),
    TaskModel(name: 'Buy eggs'),
    TaskModel(name: 'Buy bread'),
  ];

  List<TaskModel> get tasks => _tasks;

  int get taskCount => _tasks.length;

  void addTask(String newTaskTitle) {
    _tasks.add(TaskModel(name: newTaskTitle));
  }

  void updateTask(TaskModel task) {
    task.toggleCompleted();
  }

  void deleteTask(TaskModel task) {
    _tasks.remove(task);
  }
}
