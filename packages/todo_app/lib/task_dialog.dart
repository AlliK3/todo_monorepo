import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class TaskDialog extends HookWidget {
  final Function(String) onTaskAdded;

  const TaskDialog({super.key, required this.onTaskAdded});

   @override
  Widget build(BuildContext context) {
  final TextEditingController _textController = TextEditingController();

  void _submit() {
    String taskTitle = _textController.text.trim();
    if (taskTitle.isNotEmpty) {
      onTaskAdded(taskTitle);
      Navigator.of(context).pop();
    }
  }


    return AlertDialog(
      title: const Text('Add new task'),
      content: TextField(
        controller: _textController,
        decoration: const InputDecoration(hintText: 'Enter new task title'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        TextButton(onPressed: _submit, child: const Text('Add'))
      ],
    );
  }
}
