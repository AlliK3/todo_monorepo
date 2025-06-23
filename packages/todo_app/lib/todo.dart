import 'package:freezed_annotation/freezed_annotation.dart';
import 'task.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class TodoList with _$TodoList {
  const factory TodoList(List<Task> tasks) = _TodoList;

  factory TodoList.fromJson(Map<String, dynamic> json) =>
      _$TodoListFromJson(json);
}
