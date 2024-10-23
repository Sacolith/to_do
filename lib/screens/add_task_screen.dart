import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({super.key, this.task});

  final TextEditingController _nameController=TextEditingController();
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
            Text(task==null?
              'Add Task':'Update task',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 30.0,
              ),
            ),
             TextField(
              autofocus: true,
              controller: _nameController,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                     if(_nameController.text.isEmpty){
                      return;
                     }
                     final tm= TaskModel(
                      name: _nameController.text,
                      isCompleted: task?.isCompleted ?? false,
                      );
                     if(task==null){
                      //adds a new task
                      Provider.of<TaskProvider>(context, listen:false).addTask(tm);
                     }
                     //updates task
                     Provider.of<TaskProvider>(context, listen: false).udpateTask(tm);
                    Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              child:  Text(task==null?'Add':'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
