import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key, this.task, required this.onTaskAdded}) {
    if (task != null) {
      _nameController.text = task!.name;
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TaskModel? task;
  final VoidCallback onTaskAdded; // Add this line

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              task == null ? 'Add Task' : 'Update task',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 30.0,
              ),
            ),
            TextField(
              autofocus: true,
              controller: _nameController,
              onSubmitted: (value) => _addTask(context),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  _addTask(context);
                }
              },
              child: Text(task == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTask(BuildContext context) {
    if (_nameController.text.isNotEmpty) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      if (task == null) {
        taskProvider.addTask(TaskModel(name: _nameController.text));
      } else {
        taskProvider.updateTask(TaskModel(name: _nameController.text));
      }
      onTaskAdded(); // Add this line
      Navigator.pop(context);
    }
  }
}
