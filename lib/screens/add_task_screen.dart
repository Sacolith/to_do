import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key, this.task, required this.onTaskAdded});

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
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  // Add task to the provider or database
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    TaskModel(name: _nameController.text, isCompleted: false),
                  );
                  onTaskAdded(); // Call the callback
                  Navigator.pop(context);
                }
              },
              child: Text(task == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
