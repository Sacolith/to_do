import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;

  final VoidCallback onDismissed;

  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onDismissed,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  TaskModel? _recentlyDeletedTask;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Dismissible(
        key: Key(widget.taskModel.name),
        background: _buildDismissibleBackground(Alignment.centerLeft),
        secondaryBackground: _buildDismissibleBackground(Alignment.centerRight),
        onDismissed: (direction) => widget.onDismissed(),
        child: _buildTaskCard(context),
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

  void _showEditDialog(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final TextEditingController controller =
        TextEditingController(text: widget.taskModel.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedTask = TaskModel(
                  name: controller.text,
                  isCompleted: widget.taskModel.isCompleted,
                );
                await taskProvider.editTask(updatedTask);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showEditDialog(context);
      },
      child: Card(
        child: ListTile(
          title: Text(
            widget.taskModel.name,
            style: TextStyle(
                decoration: widget.taskModel.isCompleted
                    ? TextDecoration.lineThrough
                    : null),
          ),
          trailing: Checkbox(
            activeColor: Colors.deepOrangeAccent,
            value: widget.taskModel.isCompleted,
            onChanged: (bool? value) {
              Provider.of<TaskProvider>(context, listen: false).updateTask(
                  TaskModel(name: widget.taskModel.name, isCompleted: value!));
            },
          ),
        ),
      ),
    );
  }
}
