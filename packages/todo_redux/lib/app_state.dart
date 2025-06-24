import 'package:todo_ui/task.dart';

class AppState {
  final List<Task> tasks;

  AppState({this.tasks= const[]});

  AppState copyWith({List<Task>? tasks}) {
    return AppState(
      tasks: tasks ?? this.tasks,
    );
  }
}