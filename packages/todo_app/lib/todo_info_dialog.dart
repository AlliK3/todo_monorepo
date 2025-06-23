import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class TodoInfoDialog extends StatelessWidget {
  final TodoList todoList;

  const TodoInfoDialog({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    final total = todoList.tasks.length;
    final completed = todoList.tasks.where((t) => t.isChecked).length;
    final pending = total - completed;

    return AlertDialog(
      title: const Text('Todo List Info'),
      content: Text(
        'You have $total task(s).\n'
        'Completed: $completed\n'
        'Pending: $pending',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
