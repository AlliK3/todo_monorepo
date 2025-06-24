import 'package:todo_ui/task.dart';

class AddTaskAction {
  final Task task;

  AddTaskAction(this.task);
}

class ToggleTaskAction {
  final int index;

  ToggleTaskAction(this.index);
}

class DeleteTaskAction {
  final int index;
  
  DeleteTaskAction(this.index);
}