import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback onTaskDeleted;
  final VoidCallback onTaskUndo;

  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onTaskDeleted,
    required this.onTaskUndo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Dismissible(
        key: Key(taskModel.name),
        background: _buildDismissibleBackground(Alignment.centerLeft),
        secondaryBackground: _buildDismissibleBackground(Alignment.centerRight),
        onDismissed: (direction) => _handleDismiss(context),
        child: _buildTaskCard(context),
      ),
    );
  }

  void _handleDismiss(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.deleteTasks(taskModel.name);
    onTaskDeleted();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${taskModel.name} dismissed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            taskProvider.addTask(taskModel);
            onTaskUndo();
          },
        ),
      ),
    );
  }

  Widget _buildDismissibleBackground(Alignment alignment) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          taskModel.name,
          style: TextStyle(
              decoration:
                  taskModel.isCompleted ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          activeColor: Colors.deepOrangeAccent,
          value: taskModel.isCompleted,
          onChanged: (bool? value) {
            Provider.of<TaskProvider>(context, listen: false)
                .toggleTaskCompletion(taskModel.name);
          },
        ),
      ),
    );
  }
}
