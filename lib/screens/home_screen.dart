import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/screens/add_task_screen.dart';
import 'package:to_do/services/task_service.dart';
import 'package:to_do/widgets/tasks_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _taskCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchTaskCount();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  Future<void> _fetchTaskCount() async {
    int count = await TaskService().getTaskCount();
    setState(() {
      _taskCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskScreen(
                        onTaskAdded: () {
                          _fetchTaskCount();
                        },
                      ),
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(Icons.list,
                      color: Colors.deepOrangeAccent, size: 30.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'TodoApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$_taskCount Tasks',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(
                onTaskDeleted: () {
                  _fetchTaskCount();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
