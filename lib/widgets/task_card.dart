import 'package:flutter/material.dart';

/// A widget that represents a task card.
class TaskCard extends StatelessWidget {
  /// Constructs a [TaskCard] widget.
  ///
  /// The [isChecked] parameter specifies whether the task is checked or not.
  /// The [taskTitle] parameter specifies the title of the task.
  const TaskCard({super.key, required this.isChecked, required this.taskTitle});

  /// Indicates whether the task is checked or not.
  final bool isChecked;

  /// The title of the task.
  final String taskTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: (value) {
          // setState(() {
          //   isChecked = value!;
          // });
        },
      ),
    );
  }
}
