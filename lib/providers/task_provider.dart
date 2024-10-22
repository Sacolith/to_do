import 'package:flutter/material.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/task_service.dart';


class TaskProvider with ChangeNotifier{
  List<TaskModel> _task=[];

  List<TaskModel> get tasks=>_task;

  void loadTasks() async{
 _task= await TaskService().taskscontents(); 
 notifyListeners();
  }

void addTask(TaskModel task) async{
await TaskService().addTask(task);
_task.add(task);
notifyListeners();
debugPrint('add task from provider');
}

void udpateTask(TaskModel task)async{
await TaskService().updateTask(task);
int index = _task.indexWhere((t)=> t.name==task.name);
if(index !=-1){
  _task[index] =task;
  notifyListeners();
  debugPrint('update task from provider');
}
}

  void deleteTasks(String name) async{
await TaskService().deleteTask(name);
_task.removeWhere((task)=> task.name==name);
notifyListeners();
debugPrint('delete task from provider');
  }


  void toggleTaskCompletion(String name)async{
 int index = _task.indexWhere((task)=> task.name== name);
 if(index !=-1){
TaskModel taskModel =_task[index];
taskModel= TaskModel(
  name: taskModel.name, 
 isCompleted: !taskModel.isCompleted
 );
 
  udpateTask(taskModel);
 }
  }
}