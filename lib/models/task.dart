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

  /// Toggles the completion status of the task.
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
