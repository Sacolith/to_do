import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';


/// A widget that represents a task card.
class TaskCard extends StatelessWidget {
  /// Constructs a [TaskCard] widget.
  ///
  
  const TaskCard({super.key,required this.taskModel });

final TaskModel taskModel;
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          taskModel.name,
          style: TextStyle(
              decoration: taskModel.isCompleted ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: taskModel.isCompleted,
          onChanged: (bool? value) {
            Provider.of<TaskProvider>(context, listen: false).toggleTaskCompletion(taskModel.name);
          },
        ),
        onTap: (){
         // Navigator.pushNamed(context, 'routeName')
        },
      ),
    );
  }
}
