import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/widgets/task_card.dart';

/// A widget that displays a list of tasks.
class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskCard(taskModel: taskData.tasks[index]);
          },
          itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
