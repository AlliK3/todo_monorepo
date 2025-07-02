import 'package:flutter/material.dart';
import 'package:todo_ui/todo.dart';

class TodoProvider extends ChangeNotifier {
  final TodoList _todoList = const TodoList([]);
  bool _isLoading = false;

  Future<void> addTodo(String title) async {
    _isLoading = true;
    notifyListeners();
    // Add to Supabase and update local state
    _isLoading = false;
    notifyListeners();

  }
}
