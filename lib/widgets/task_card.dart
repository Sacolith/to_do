import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback onTaskDeleted; // Add this line

  const TaskCard(
      {super.key,
      required this.taskModel,
      required this.onTaskDeleted}); // Modify constructor

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taskModel.name),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        // Remove the task from the provider
        Provider.of<TaskProvider>(context, listen: false)
            .deleteTasks(taskModel.name);
        // Call the callback
        onTaskDeleted();
        // Show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${taskModel.name} dismissed')),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(
            taskModel.name,
            style: TextStyle(
              decoration:
                  taskModel.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            activeColor: Colors.lightBlueAccent,
            value: taskModel.isCompleted,
            onChanged: (bool? value) {
              // Handle checkbox change
            },
          ),
        ),
      ),
    );
  }
}
