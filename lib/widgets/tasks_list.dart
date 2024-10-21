import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/services/task_service.dart';
import 'package:to_do/widgets/task_card.dart';

/// A widget that displays a list of tasks.
class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskService>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskCard(
              taskTitle: task.name,
              isChecked: task.isCompleted,
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
