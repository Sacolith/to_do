import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/widgets/task_card.dart';

/// A widget that displays a list of tasks.
class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    TaskModel? _recentlyDeletedTask;
    return Consumer<TaskProvider>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskProvider.tasks[index];
            return TaskCard(
              taskModel: task,
              onDismissed: () async {
                _recentlyDeletedTask = task;
                await taskProvider.deleteTasks(task.name);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${task.name} dismissed'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () async {
                        if (_recentlyDeletedTask != null) {
                          await taskProvider.addTask(_recentlyDeletedTask!);
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
          itemCount: taskData.tasks.length,
        );
      },
    );
  }
}
