/// Creates a Set of default values for a task or to do.
class TaskModel {
  final String name;
  bool isCompleted;

  /// Constructs a [TaskModel] with the given [name] and optional [isCompleted] value.
  ///
  /// The [name] parameter is required and represents the name of the task.
  /// The [isCompleted] parameter is optional and defaults to `false`.
  /// Setting [isCompleted] to `true` indicates that the task is completed.
  TaskModel({
    required this.name,
    this.isCompleted = false,
  });

 ///Creates reusable map of tasks to be used when creating [tasks]
  Map<String, dynamic> tasks(){
    return{
      'name':name,
      'isComplete':isCompleted
    };
  }

 ///Helps to maintain a consistent [tasks] structure 
 ///Useful for adding different values of type [TaskModel] and ensuring the model stays consistent
 factory TaskModel.fromMap(Map<String, dynamic> taskmap){
     return TaskModel(
      name: taskmap['name'],
      isCompleted: taskmap['isCompleted'] ?? false
      );
 }

  /// Toggles the completion status of the task.
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
