import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key, this.task}) {
    if (task != null) {
      _nameController.text = task!.name;
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TaskModel? task;

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

  void _addTask(BuildContext context) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if (task == null) {
      await taskProvider.addTask(TaskModel(name: _nameController.text));
    } else {
      await taskProvider.updateTask(TaskModel(
          name: _nameController.text, isCompleted: task!.isCompleted));
    }

    Navigator.pop(context);
  }
}
