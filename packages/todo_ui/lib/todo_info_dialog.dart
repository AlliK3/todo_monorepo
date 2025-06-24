import 'package:flutter/material.dart';
import 'package:todo_ui/todo.dart';

class TodoInfoPage extends StatelessWidget {
  final TodoList todoList;

  const TodoInfoPage({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    final total = todoList.tasks.length;
    final completed = todoList.tasks.where((t) => t.isChecked).length;
    final pending = total - completed;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total tasks: $total', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Completed: $completed', style: Theme.of(context).textTheme.bodyLarge),
            Text('Pending: $pending', style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
